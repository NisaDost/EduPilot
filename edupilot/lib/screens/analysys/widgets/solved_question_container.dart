import 'dart:math';
import 'package:edupilot/models/dtos/choice_dto.dart';
import 'package:edupilot/models/dtos/solved_question_dto.dart';
import 'package:edupilot/models/dtos/solved_quiz_dto.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:edupilot/theme.dart';

class SolvedQuestionContainer extends StatefulWidget {
  final SolvedQuizDTO quiz;
  final String quizId;
  final SolvedQuestionDTO question;
  final int questionIndex;
  final int totalQuestions;
  final VoidCallback onNext;
  final VoidCallback? onPrevious;
  final bool isLastQuestion;
  final String? selectedChoiceId;

  const SolvedQuestionContainer({
    super.key,
    required this.quiz,
    required this.quizId,
    required this.question,
    required this.questionIndex,
    required this.totalQuestions,
    required this.onNext,
    this.onPrevious,
    required this.isLastQuestion,
    required this.selectedChoiceId,
  });

  @override
  State<SolvedQuestionContainer> createState() => _SolvedQuestionContainerState();
}

class _SolvedQuestionContainerState extends State<SolvedQuestionContainer>
    with TickerProviderStateMixin {
  static final Map<int, List<ChoiceDTO>> _shuffledChoicesCache = {};
  late List<ChoiceDTO> _shuffledChoices;
  final Map<int, double> _scaleFactors = {};

  @override
  void initState() {
    super.initState();
    _initializeOrRetrieveChoices();
  }

  @override
  void didUpdateWidget(covariant SolvedQuestionContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.questionIndex != widget.questionIndex || oldWidget.selectedChoiceId != widget.selectedChoiceId) {
      _initializeOrRetrieveChoices();
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
            final label = choice.choiceId != null ? String.fromCharCode(65 + i) : '-';

            // Default colors
            Color borderColor = AppColors.secondaryColor;
            Color labelBgColor = AppColors.secondaryColor;

            final isCorrectChoice = choice.isCorrect;
            final isSelected = choice.choiceId == widget.selectedChoiceId;
            final isNullChoice = choice.choiceId == null;

            // Case 1: If this is the null choice (-)
            if (isNullChoice) {
              // If selectedChoiceId is null (meaning user left question blank)
              if (widget.selectedChoiceId == '00000000-0000-0000-0000-000000000000') {
                borderColor = AppColors.dangerColor;
                labelBgColor = AppColors.dangerColor;
              }
              // Otherwise keep default secondaryColor for the null choice
            }
            // Case 2: If this is the correct answer, always highlight in green
            else if (isCorrectChoice) {
              borderColor = AppColors.successColor;
              labelBgColor = AppColors.successColor;
            }
            // Case 3: If this is the user's selected wrong answer
            else if (isSelected && !isCorrectChoice) {
              borderColor = AppColors.dangerColor;
              labelBgColor = AppColors.dangerColor;
            }

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: labelBgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: label.isNotEmpty
                        ? LargeText(label, AppColors.backgroundColor)
                        : Icon(Icons.not_interested, color: AppColors.backgroundColor),
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
          
          // Navigation row with conditional buttons
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
              // Show "Next Question" button only if it's not the last question
              if (!widget.isLastQuestion)
                TextButton(
                  onPressed: widget.onNext,
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24),
                  ),
                  child: MediumText("Sonraki Soru", AppColors.backgroundColor),
                ),
            ],
          ),
          
          // Add spacing between the navigation row and exit button
          const SizedBox(height: 16),
          
          // "İncelemeden Çık" button with full width
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: MediumText("İncelemeden Çık", AppColors.backgroundColor),
            ),
          ),
        ],
      ),
    );
  }
}