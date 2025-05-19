import 'dart:async';
import 'package:edupilot/models/dtos/solved_quiz_dto.dart';
import 'package:edupilot/screens/analysys/widgets/solved_question_container.dart';
import 'package:edupilot/services/quizzes_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class SolvedQuizScreen extends StatefulWidget {
  const SolvedQuizScreen({required this.quizId, super.key});

  final String quizId;

  @override
  State<SolvedQuizScreen> createState() => _SolvedQuizScreenState();
}

class _SolvedQuizScreenState extends State<SolvedQuizScreen> {
  SolvedQuizDTO? _quiz;
  bool _isLoading = true;
  int _currentQuestionIndex = 0;
  Map<int, String> selectedChoices = {};

  @override
  void initState() {
    super.initState();
    _loadQuiz();
  }

  Future<void> _loadQuiz() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final quiz = await QuizzesApiHandler().getSolvedQuiz(widget.quizId);
      debugPrint("Quiz data: ${quiz.toJson()}");
      // Check if widget is still mounted after async call
      if (!mounted) return;

      if (quiz.solvedQuestions.isEmpty) {
        setState(() {
          _isLoading = false;
          _quiz = null; // Explicitly set to null for empty quiz
        });
        return;
      }
      // Set the quiz data and start timer
      setState(() {
        _quiz = quiz;
        _isLoading = false;
      });
      
    } catch (e) {
      debugPrint("Quiz load error: $e");
      if (mounted) {
        setState(() {
          _quiz = null;
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double topBarHeight = 128;

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_quiz == null) {
      return Scaffold(
        body: Center(child: Text("Quiz yüklenirken hata oluştu.")),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: topBarHeight,
            padding: const EdgeInsets.fromLTRB(20, 48, 20, 16),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(25),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  LargeBodyText('Quiz Analizi', AppColors.successColor),
                  const SizedBox(height: 10),
                  SmallText('Nerede yanlış yaptığını bulalım...', AppColors.titleColor),
                ]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        LargeText('${_currentQuestionIndex + 1}/${_quiz!.questionCount}', AppColors.textColor),
                        const SizedBox(width: 6),
                        Icon(Icons.assignment_outlined, color: AppColors.primaryColor, size: 28),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmallBodyText('Verdiğin cevap ile doğru cevabı karşılaştır...', AppColors.titleColor),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SolvedQuestionContainer(
                    quiz: _quiz!,
                    quizId: _quiz!.id,
                    question: _quiz!.solvedQuestions[_currentQuestionIndex],
                    questionIndex: _currentQuestionIndex,
                    totalQuestions: _quiz!.questionCount,
                    selectedChoiceId: _quiz!.solvedQuestions[_currentQuestionIndex].selectedChoiceId,
                    onPrevious: _currentQuestionIndex == 0
                        ? null
                        : () {
                            setState(() {
                              _currentQuestionIndex--;
                            });
                          },
                    onNext: () {
                      if (_currentQuestionIndex == _quiz!.questionCount - 1) {
                        //_confirmSubmit();
                      } else {
                        setState(() {
                          _currentQuestionIndex++;
                        });
                      }
                    },
                    isLastQuestion: _currentQuestionIndex == _quiz!.questionCount - 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}