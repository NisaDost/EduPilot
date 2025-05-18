import 'dart:async';
import 'package:edupilot/models/dtos/answer_dto.dart';
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

  bool _isSubmitting = false;

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

      final quiz = await QuizzesApiHandler().getQuiz(widget.quizId);
      debugPrint("Quiz data: ${quiz.toJson()}");
      // Check if widget is still mounted after async call
      if (!mounted) return;

      if (quiz.questions.isEmpty) {
        setState(() {
          _isLoading = false;
          _quiz = null; // Explicitly set to null for empty quiz
        });
        return;
      }

      // Set the quiz data and start timer
      setState(() {
        _quiz = quiz;
        _remainingSeconds = quiz.duration * 60;
        _isLoading = false;
      });
      
      _startTimer();
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

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_remainingSeconds <= 0) {
        timer.cancel();
        _submitQuiz(); // Auto submit when timer ends
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  void _submitQuiz() async {
    if (_isSubmitting) return;
    _isSubmitting = true;

    final answers = List.generate(_quiz!.questions.length, (index) {
      final question = _quiz!.questions[index];
      final choiceId = selectedChoices[index];
      return AnswerDTO(questionId: question.questionId, choiceId: choiceId);
    });

    try {
      final result = await QuizzesApiHandler().postQuizResult(_quiz!.id, answers);
      if (!mounted) return;

      showDialog(
        context: context,
        barrierDismissible: false,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LargeText('Kazanılan Puan: ${result.earnedPoints}', AppColors.primaryColor),
                    Icon(Icons.bolt, color: AppColors.primaryColor, size: 28),
                  ],
                ),
                const SizedBox(height: 10),
                MediumBodyText('Testi bitirdiğinde kalan süre', AppColors.textColor),
                MediumBodyText(_formatTime(_remainingSeconds), AppColors.textColor),
                const SizedBox(height: 20),
                LargeText('Tebrikler!', AppColors.primaryAccent),
                const SizedBox(height: 36),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )
                  ),
                  child: LargeText('Çıkış', AppColors.backgroundColor)
                )
              ],
            ),
          ),
        ),
      );

      await Future.delayed(const Duration(seconds: 2));
      if (mounted) Navigator.pop(context); // close screen
    } catch (e) {
      debugPrint('Quiz submission failed: $e');
    }
  }

  void _confirmSubmit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LargeBodyText('Quizi bitirmek istediğine emin misin?', AppColors.textColor, textAlign: TextAlign.center),
            const SizedBox(height: 32),
            SmallBodyText('Soruları gözden geçirmek istersen iptal butonuna tıkla.', AppColors.titleColor, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            SmallBodyText('Quizi bitirirsen geri dönemezsin ve doğru cevaplarına göre kazandığın puanlar hesaplanır.', AppColors.titleColor, textAlign: TextAlign.center),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: MediumBodyText('İptal', AppColors.backgroundColor)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _submitQuiz();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: MediumBodyText('Quizi Bitir', AppColors.backgroundColor)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return "$minutes dk $seconds sn";
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
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  LargeBodyText(widget.lessonName, AppColors.successColor),
                  const SizedBox(height: 10),
                  SmallText(widget.subjectName, AppColors.titleColor),
                ]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        LargeText(_formatTime(_remainingSeconds),
                          _remainingSeconds > (_quiz!.duration * 30) 
                              ? AppColors.textColor
                              : _remainingSeconds <= 60
                                ? AppColors.dangerColor
                                : AppColors.secondaryColor,
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.timer,
                          color: _remainingSeconds > (_quiz!.duration * 30)
                              ? AppColors.primaryColor
                              : _remainingSeconds <= 60
                                ? AppColors.dangerColor
                                : AppColors.secondaryColor,
                          size: 28,
                        ),
                      ],
                    ),
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
                        SmallBodyText('Doğru cevap ${_quiz!.pointPerQuestion}', AppColors.titleColor),
                        Icon(Icons.bolt, color: AppColors.titleColor, size: 16),
                        SmallBodyText('değerinde!', AppColors.titleColor)
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  QuestionsContainer(
                    quiz: _quiz!,
                    quizId: _quiz!.id,
                    selectedChoices: selectedChoices,
                    question: _quiz!.questions[_currentQuestionIndex],
                    questionIndex: _currentQuestionIndex,
                    totalQuestions: _quiz!.questionCount,
                    onChoiceSelected: (choiceId) {
                      selectedChoices[_currentQuestionIndex] = choiceId!;
                    },
                    selectedChoiceId: selectedChoices[_currentQuestionIndex],
                    onPrevious: _currentQuestionIndex == 0
                        ? null
                        : () {
                            setState(() {
                              _currentQuestionIndex--;
                            });
                          },
                    onNext: () {
                      if (_currentQuestionIndex == _quiz!.questionCount - 1) {
                        _confirmSubmit();
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