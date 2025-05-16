import 'dart:math';
import 'package:edupilot/models/dtos/answer_dto.dart';
import 'package:edupilot/models/dtos/choice_dto.dart';
import 'package:edupilot/models/dtos/question_dto.dart';
import 'package:edupilot/models/dtos/quiz_dto.dart';
import 'package:edupilot/services/quizzes_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:edupilot/theme.dart';

class QuestionsContainer extends StatefulWidget {
  final QuizDTO quiz;
  final Map<int, String> selectedChoices;
  final String quizId;
  final QuestionDTO question;
  final int questionIndex;
  final int totalQuestions;
  final VoidCallback onNext;
  final VoidCallback? onPrevious;
  final bool isLastQuestion;
  final ValueChanged<String?> onChoiceSelected;
  final String? selectedChoiceId;

  const QuestionsContainer({
    super.key,
    required this.quiz,
    required this.selectedChoices,
    required this.quizId,
    required this.question,
    required this.questionIndex,
    required this.totalQuestions,
    required this.onNext,
    this.onPrevious,
    required this.isLastQuestion,
    required this.onChoiceSelected,
    required this.selectedChoiceId,
  });

  @override
  State<QuestionsContainer> createState() => _QuestionsContainerState();
}

class _QuestionsContainerState extends State<QuestionsContainer>
    with TickerProviderStateMixin {
  static final Map<int, List<ChoiceDTO>> _shuffledChoicesCache = {};
  late List<ChoiceDTO> _shuffledChoices;
  int? _selectedIndex;
  final Map<int, double> _scaleFactors = {};
  final double _pressedScale = 1.1;

  @override
  void initState() {
    super.initState();
    _initializeOrRetrieveChoices();
    _selectedIndex = _shuffledChoices.indexWhere((c) => c.choiceId == widget.selectedChoiceId);
    if (_selectedIndex == -1) {
      _selectedIndex = 0;
      widget.onChoiceSelected(null);
    }
  }

  @override
  void didUpdateWidget(covariant QuestionsContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.questionIndex != widget.questionIndex || oldWidget.selectedChoiceId != widget.selectedChoiceId) {
      _initializeOrRetrieveChoices();
      _selectedIndex = _shuffledChoices.indexWhere((c) => c.choiceId == widget.selectedChoiceId);
    }
  }

  void _initializeOrRetrieveChoices() {
    if (_shuffledChoicesCache.containsKey(widget.questionIndex)) {
      _shuffledChoices = _shuffledChoicesCache[widget.questionIndex]!;
    } else {
      final realChoices = List<ChoiceDTO>.from(widget.question.choices)..shuffle(Random());
      realChoices.add(ChoiceDTO(
        choiceId: null,
        choiceContent: 'Bu soruyu boş bırak',
        isCorrect: false,
      ));
      _shuffledChoices = realChoices;
      _shuffledChoicesCache[widget.questionIndex] = _shuffledChoices;
    }

    _scaleFactors.clear();
    for (int i = 0; i < _shuffledChoices.length; i++) {
      _scaleFactors[i] = 1.0;
    }
  }

  void _onChoiceSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _scaleFactors[index] = _pressedScale;
    });
    final selectedChoiceId = _shuffledChoices[index].choiceId;
    widget.onChoiceSelected(selectedChoiceId!);
    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        _scaleFactors[index] = 1.0;
      });
    });
  }

  void _submitQuizAndShowResult() async {
    Navigator.pop(context); // close dialog

    final answers = List.generate(widget.quiz.questions.length, (index) {
      final question = widget.quiz.questions[index];
      final choiceId = widget.selectedChoices[index];
      return AnswerDTO(
        questionId: question.questionId,
        choiceId: choiceId,
      );
    });

    try {
      final result = await QuizzesApiHandler().postQuizResult(widget.quizId, answers);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: AppColors.backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LargeBodyText('Sonuçlar', AppColors.textColor),
                const SizedBox(height: 20),
                MediumBodyText('Doğru: ${result.trueCount}', AppColors.successColor),
                MediumBodyText('Yanlış: ${result.falseCount}', AppColors.dangerColor),
                MediumBodyText('Boş: ${result.emptyCount}', AppColors.titleColor),
                MediumBodyText('Toplam: ${result.totalCount}', AppColors.textColor),
                const SizedBox(height: 10),
                Row(
                  children: [
                    LargeText('Kazanılan Puan: ${result.earnedPoints}', AppColors.primaryColor),
                    Icon(Icons.bolt, color: AppColors.primaryColor, size: 56),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      debugPrint('Quiz submit failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.question.questionImage != null &&
              widget.question.questionImage!.isNotEmpty)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 12),
              child: Image.asset(
                'assets/img/temp/${widget.question.questionImage!}',
                fit: BoxFit.contain,
              ),
            ),
          Text(
            widget.question.questionContent,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16),
          ...List.generate(_shuffledChoices.length, (i) {
            final choice = _shuffledChoices[i];
            final isSelected = i == _selectedIndex;
            final label = choice.choiceId != null ? String.fromCharCode(65 + i) : '-';
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  AnimatedScale(
                    scale: _scaleFactors[i] ?? 1.0,
                    duration: const Duration(milliseconds: 150),
                    child: TextButton(
                      onPressed: () => _onChoiceSelected(i),
                      style: TextButton.styleFrom(
                        minimumSize: const Size(40, 40),
                        padding: const EdgeInsets.all(6),
                        backgroundColor: isSelected
                            ? AppColors.primaryColor
                            : AppColors.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: label.isNotEmpty
                          ? LargeText(label, AppColors.backgroundColor)
                          : Icon(Icons.not_interested, color: AppColors.backgroundColor),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MediumText(choice.choiceContent, AppColors.textColor),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 24),
          Row(
            children: [
              if (widget.onPrevious != null)
                TextButton(
                  onPressed: widget.onPrevious,
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.primaryAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24),
                  ),
                  child: MediumText("Önceki Soru", AppColors.backgroundColor),
                ),
              const Spacer(),
              TextButton(
                onPressed: widget.isLastQuestion
                    ? () => showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            backgroundColor: AppColors.backgroundColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  LargeBodyText('Quizi bitirmek istediğine emin misin?', AppColors.textColor, textAlign: TextAlign.center),
                                  const SizedBox(height: 32),
                                  SmallBodyText('Soruları gözden geçirmek istersen iptal butonuna tıkla.', AppColors.titleColor, textAlign: TextAlign.center),
                                  const SizedBox(height: 24),
                                  SmallBodyText('Quizi bitirirsen geri dönemezsin ve doğru cevaplarına göre kazandığın puanlar hesaplanır.', AppColors.titleColor, textAlign: TextAlign.center),
                                  const SizedBox(height: 32),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryAccent,
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                                            child: MediumBodyText('İptal', AppColors.backgroundColor),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: TextButton(
                                          onPressed: _submitQuizAndShowResult,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.secondaryColor,
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 9),
                                            child: MediumBodyText('Quizi Bitir', AppColors.backgroundColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                    : widget.onNext,
                style: TextButton.styleFrom(
                  backgroundColor:
                      widget.isLastQuestion ? AppColors.secondaryColor : AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24),
                ),
                child: MediumText(widget.isLastQuestion ? "Quizi Bitir" : "Sonraki Soru", AppColors.backgroundColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
