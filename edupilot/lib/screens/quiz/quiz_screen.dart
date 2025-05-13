import 'dart:async';
import 'package:edupilot/models/dtos/quiz_dto.dart';
import 'package:edupilot/screens/quiz/widgets/questions_container.dart';
import 'package:edupilot/services/quizzes_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    required this.quizId,
    required this.lessonName,
    required this.subjectName,
    super.key,
  });

  final String quizId;
  final String lessonName;
  final String subjectName;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  QuizDTO? _quiz;
  bool _isLoading = true;
  int _currentQuestionIndex = 0;
  Map<int, String> selectedChoices = {};

  int _remainingSeconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadQuiz();
  }

  Future<void> _loadQuiz() async {
    try {
      final quiz = await QuizzesApiHandler().getQuiz(widget.quizId);

      // Defensive checks
      if (quiz.questions.isEmpty) {
        debugPrint('Quiz data invalid: duration=${quiz.duration}, questions=${quiz.questions}');
        setState(() {
          _quiz = null;
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _quiz = quiz;
        _isLoading = false;
        _remainingSeconds = quiz.duration * 60;
      });

      _startTimer();
    } catch (e) {
      debugPrint("Quiz load error: $e");
      setState(() {
        _isLoading = false;
        _quiz = null;
      });
    }
  }


  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        timer.cancel();
        // handle time out here (e.g. submit quiz automatically)
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return "$minutes dk $seconds sn";
  }

  @override
  void dispose() {
    _timer?.cancel();
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
          // Fixed Top Bar
          Container(
            height: topBarHeight,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 20, top: 48, right: 20, bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LargeBodyText(widget.lessonName, AppColors.successColor),
                    const SizedBox(height: 10),
                    SmallText(widget.subjectName, AppColors.titleColor),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        LargeText(_formatTime(_remainingSeconds), AppColors.textColor),
                        const SizedBox(width: 6),
                        Icon(Icons.timer, color: AppColors.primaryColor, size: 28),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        LargeText(
                          '${_currentQuestionIndex + 1}/${_quiz!.questionCount}',
                          AppColors.textColor,
                        ),
                        const SizedBox(width: 6),
                        Icon(Icons.assignment_outlined, color: AppColors.primaryColor, size: 28),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
              child: QuestionsContainer(
                question: _quiz!.questions[_currentQuestionIndex],
                questionIndex: _currentQuestionIndex,
                totalQuestions: _quiz!.questionCount,
                isLastQuestion: _currentQuestionIndex == _quiz!.questionCount - 1,
                onChoiceSelected: (choiceId) {
                  selectedChoices[_currentQuestionIndex] = choiceId;
                },
                onPrevious: _currentQuestionIndex == 0
                    ? null
                    : () {
                        setState(() {
                          _currentQuestionIndex--;
                        });
                      },
                onNext: () {
                  if (_currentQuestionIndex == _quiz!.questionCount - 1) {
                    // TODO: handle finish
                  } else {
                    setState(() {
                      _currentQuestionIndex++;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}