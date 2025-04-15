import 'package:edupilot/models/quiz/difficulty.dart';
import 'package:edupilot/models/quiz/quiz.dart';
import 'package:edupilot/models/quiz/subject.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quiz_provider.g.dart';

// dart run build_runner watch

List<Quiz> allQuizzes = [
  Quiz(id: '1', subject: allSubjects.firstWhere((s) => s.name == 'Türev'), difficulty: Difficulty.easy, pointPerQuestion: 20, isActive: true),
  Quiz(id: '2', subject: allSubjects.firstWhere((s) => s.name == 'Köklü Sayılar'), difficulty: Difficulty.medium, pointPerQuestion: 30, isActive: true),
  Quiz(id: '3', subject: allSubjects.firstWhere((s) => s.name == 'Üçgenler'), difficulty: Difficulty.hard, pointPerQuestion: 40, isActive: true),
  Quiz(id: '4', subject: allSubjects.firstWhere((s) => s.name == 'Newton Hareket Yasaları'), difficulty: Difficulty.easy, pointPerQuestion: 20, isActive: true),
  Quiz(id: '5', subject: allSubjects.firstWhere((s) => s.name == 'Elektrik ve Manyetizma'), difficulty: Difficulty.medium, pointPerQuestion: 30, isActive: true),
  Quiz(id: '6', subject: allSubjects.firstWhere((s) => s.name == 'Optik'), difficulty: Difficulty.hard, pointPerQuestion: 40, isActive: true),
  Quiz(id: '7', subject: allSubjects.firstWhere((s) => s.name == 'Periyodik Tablo'), difficulty: Difficulty.easy, pointPerQuestion: 20, isActive: true),
  Quiz(id: '8', subject: allSubjects.firstWhere((s) => s.name == 'Asitler ve Bazlar'), difficulty: Difficulty.medium, pointPerQuestion: 30, isActive: true),
  Quiz(id: '9', subject: allSubjects.firstWhere((s) => s.name == 'Kimyasal Tepkimeler'), difficulty: Difficulty.hard, pointPerQuestion: 40, isActive: true),
  Quiz(id: '10', subject: allSubjects.firstWhere((s) => s.name == 'Hücre Yapısı'), difficulty: Difficulty.easy, pointPerQuestion: 20, isActive: true),
  Quiz(id: '11', subject: allSubjects.firstWhere((s) => s.name == 'Genetik ve Kalıtım'), difficulty: Difficulty.medium, pointPerQuestion: 30, isActive: true),
  Quiz(id: '12', subject: allSubjects.firstWhere((s) => s.name == 'Fotosentez'), difficulty: Difficulty.hard, pointPerQuestion: 40, isActive: true),
  Quiz(id: '13', subject: allSubjects.firstWhere((s) => s.name == 'Osmanlı Tarihi'), difficulty: Difficulty.easy, pointPerQuestion: 20, isActive: true),
  Quiz(id: '14', subject: allSubjects.firstWhere((s) => s.name == 'Türk İnkılabı'), difficulty: Difficulty.medium, pointPerQuestion: 30, isActive: true),
  Quiz(id: '15', subject: allSubjects.firstWhere((s) => s.name == 'Sanayi Devrimi'), difficulty: Difficulty.hard, pointPerQuestion: 40, isActive: true),
  Quiz(id: '16', subject: allSubjects.firstWhere((s) => s.name == 'İklim Tipleri'), difficulty: Difficulty.easy, pointPerQuestion: 20, isActive: true),
  Quiz(id: '17', subject: allSubjects.firstWhere((s) => s.name == 'Yer Şekilleri'), difficulty: Difficulty.medium, pointPerQuestion: 30, isActive: true),
  Quiz(id: '18', subject: allSubjects.firstWhere((s) => s.name == 'Nüfus ve Göç'), difficulty: Difficulty.hard, pointPerQuestion: 40, isActive: true),
  Quiz(id: '19', subject: allSubjects.firstWhere((s) => s.name == 'Bilgi Felsefesi'), difficulty: Difficulty.easy, pointPerQuestion: 20, isActive: true),
  Quiz(id: '20', subject: allSubjects.firstWhere((s) => s.name == 'Ahlak Felsefesi'), difficulty: Difficulty.medium, pointPerQuestion: 30, isActive: true),
  Quiz(id: '21', subject: allSubjects.firstWhere((s) => s.name == 'Varlık Felsefesi'), difficulty: Difficulty.hard, pointPerQuestion: 40, isActive: true),
  Quiz(id: '22', subject: allSubjects.firstWhere((s) => s.name == 'İslam’ın Temel İlkeleri'), difficulty: Difficulty.easy, pointPerQuestion: 20, isActive: true),
  Quiz(id: '23', subject: allSubjects.firstWhere((s) => s.name == 'Peygamberler Tarihi'), difficulty: Difficulty.medium, pointPerQuestion: 30, isActive: true),
  Quiz(id: '24', subject: allSubjects.firstWhere((s) => s.name == 'Tenses'), difficulty: Difficulty.hard, pointPerQuestion: 40, isActive: true),
  Quiz(id: '25', subject: allSubjects.firstWhere((s) => s.name == 'Modal Verbs'), difficulty: Difficulty.easy, pointPerQuestion: 20, isActive: true),
  Quiz(id: '26', subject: allSubjects.firstWhere((s) => s.name == 'Passive Voice'), difficulty: Difficulty.medium, pointPerQuestion: 30, isActive: true),
];

@riverpod
class QuizNotifier extends _$QuizNotifier {

  // inital value
  @override
  Set<Quiz> build() {
    return const {};
  }
}

// generated providers

@riverpod
List<Quiz> quizzes(ref) {
  return allQuizzes;
}

@riverpod
List<Quiz> activeQuizzes(ref) {
  return allQuizzes.where((q) => q.isActive).toList();
}