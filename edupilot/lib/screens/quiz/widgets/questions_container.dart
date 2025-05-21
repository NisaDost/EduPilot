import 'dart:math';
import 'package:edupilot/models/dtos/choice_dto.dart';
import 'package:edupilot/models/dtos/question_dto.dart';
import 'package:edupilot/models/dtos/quiz_dto.dart';
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
              child: Image.network(widget.question.questionImage!,
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

            return InkWell(
              onTap: () => _onChoiceSelected(i),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryAccent.withOpacity(0.1) : null,
                  border: Border.all(
                    color: isSelected ? AppColors.primaryColor : AppColors.secondaryColor,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primaryColor : AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: label.isNotEmpty
                          ? LargeText(label, AppColors.backgroundColor)
                          : Icon(Icons.not_interested, color: AppColors.backgroundColor),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MediumText(choice.choiceContent, AppColors.textColor),
                    ),
                  ],
                ),
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
                onPressed: widget.onNext,
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
