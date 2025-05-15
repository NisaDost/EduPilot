import 'dart:math';
import 'package:edupilot/models/dtos/choice_dto.dart';
import 'package:edupilot/models/dtos/question_dto.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:edupilot/theme.dart';

class QuestionsContainer extends StatefulWidget {
  final QuestionDTO question;
  final int questionIndex;
  final int totalQuestions;
  final VoidCallback onNext;
  final VoidCallback? onPrevious;
  final bool isLastQuestion;
  final ValueChanged<String> onChoiceSelected;
  final String? selectedChoiceId;

  const QuestionsContainer({
    super.key,
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
      _shuffledChoices = List<ChoiceDTO>.from(widget.question.choices);
      _shuffledChoices.shuffle(Random());
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
    widget.onChoiceSelected(selectedChoiceId); // 🔹 Notify parent

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
            final letter = String.fromCharCode(65 + i);
            final choice = _shuffledChoices[i];
            final isSelected = i == _selectedIndex;

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
                      child: LargeText(letter, AppColors.backgroundColor),
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
                ElevatedButton(
                  onPressed: widget.onPrevious,
                  child: const Text("Önceki Soru"),
                ),
              const Spacer(),
              ElevatedButton(
                onPressed: widget.onNext,
                child: Text(widget.isLastQuestion ? "Quizi Bitir" : "Sonraki Soru"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
