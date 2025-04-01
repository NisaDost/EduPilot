import 'package:edupilot/models/quiz/difficulty.dart';
import 'package:edupilot/models/quiz/lesson.dart';
import 'package:edupilot/models/quiz/subject.dart';

class Quiz {

  // contructor
  Quiz({
    required this.id,
    required this.lesson,
    required this.subject,
    required this.description,
    required this.duration,
    required this.questionCount,
    required this.difficulty,
    required this.grade,
  });

  // fields
  final String id;
  final Lesson lesson;
  final Subject subject;
  final String description;
  final Duration duration;
  final int questionCount;
  final Difficulty difficulty;
  final int grade;
}

// dummy quiz data
List<Quiz> quizes = [
  // Math Quizzes
  Quiz(
    id: '1',
    lesson: Lesson.math,
    subject: allSubjects.firstWhere((s) => s.id == '1'),
    description: 'asdasd',
    duration: Duration(minutes: 20),
    questionCount: 15,
    difficulty: Difficulty.extreme,
    grade: 8,
  ),
  Quiz(
    id: '2',
    lesson: Lesson.math,
    subject: allSubjects.firstWhere((s) => s.id == '2'),
    description: 'asdfdsf',
    duration: Duration(minutes: 25),
    questionCount: 20,
    difficulty: Difficulty.hard,
    grade: 8,
  ),

  // Geography Quizzes
  Quiz(
    id: '3',
    lesson: Lesson.geography,
    subject: allSubjects.firstWhere((s) => s.id == '19'),
    description: 'fsdfsdfsd',
    duration: Duration(minutes: 15),
    questionCount: 10,
    difficulty: Difficulty.easy,
    grade: 8,
  ),
  Quiz(
    id: '4',
    lesson: Lesson.geography,
    subject: allSubjects.firstWhere((s) => s.id == '20'),
    description: 'fdhfhdfdf',
    duration: Duration(minutes: 20),
    questionCount: 15,
    difficulty: Difficulty.medium,
    grade: 8,
  ),

  // English Quizzes
  Quiz(
    id: '5',
    lesson: Lesson.english,
    subject: allSubjects.firstWhere((s) => s.id == '32'),
    description: 'hdfhfdgdfg',
    duration: Duration(minutes: 15),
    questionCount: 12,
    difficulty: Difficulty.easy,
    grade: 8,
  ),
  Quiz(
    id: '6',
    lesson: Lesson.english,
    subject: allSubjects.firstWhere((s) => s.id == '33'),
    description: 'dfhdfhfdg',
    duration: Duration(minutes: 20),
    questionCount: 18,
    difficulty: Difficulty.medium,
    grade: 8,
  ),
];
