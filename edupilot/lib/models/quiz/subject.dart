import 'package:edupilot/models/quiz/lesson.dart';
import 'package:edupilot/providers/lesson_provider.dart';

class Subject {

  final String id;
  final Lesson lesson;
  final String name;

  Subject({
    required this.id,
    required this.lesson,
    required this.name,
  });
}

final List<Subject> allSubjects = [
  // math
  Subject(id: '1', lesson: allLessons.firstWhere((l) => l.name == 'Matematik'), name: 'Köklü Sayılar'),
  Subject(id: '2', lesson: allLessons.firstWhere((l) => l.name == 'Matematik'), name: 'Türev'),
  Subject(id: '3', lesson: allLessons.firstWhere((l) => l.name == 'Matematik'), name: 'Integral'),

  // geometry
  Subject(id: '4', lesson: allLessons.firstWhere((l) => l.name == 'Geometri'), name: 'Üçgenler'),
  Subject(id: '5', lesson: allLessons.firstWhere((l) => l.name == 'Geometri'), name: 'Prizmalar'),
  Subject(id: '6', lesson: allLessons.firstWhere((l) => l.name == 'Geometri'), name: 'Çemberler'),

  // physics
  Subject(id: '7', lesson: allLessons.firstWhere((l) => l.name == 'Fizik'), name: 'Newton Hareket Yasaları'),
  Subject(id: '8', lesson: allLessons.firstWhere((l) => l.name == 'Fizik'), name: 'Elektrik ve Manyetizma'),
  Subject(id: '9', lesson: allLessons.firstWhere((l) => l.name == 'Fizik'), name: 'Optik'),

  // chemistry
  Subject(id: '10', lesson: allLessons.firstWhere((l) => l.name == 'Kimya'), name: 'Periyodik Tablo'),
  Subject(id: '11', lesson: allLessons.firstWhere((l) => l.name == 'Kimya'), name: 'Asitler ve Bazlar'),
  Subject(id: '12', lesson: allLessons.firstWhere((l) => l.name == 'Kimya'), name: 'Kimyasal Tepkimeler'),

  // biology
  Subject(id: '13', lesson: allLessons.firstWhere((l) => l.name == 'Biyoloji'), name: 'Hücre Yapısı'),
  Subject(id: '14', lesson: allLessons.firstWhere((l) => l.name == 'Biyoloji'), name: 'Genetik ve Kalıtım'),
  Subject(id: '15', lesson: allLessons.firstWhere((l) => l.name == 'Biyoloji'), name: 'Fotosentez'),

  // history
  Subject(id: '16', lesson: allLessons.firstWhere((l) => l.name == 'Tarih'), name: 'Osmanlı Tarihi'),
  Subject(id: '17', lesson: allLessons.firstWhere((l) => l.name == 'Tarih'), name: 'Türk İnkılabı'),
  Subject(id: '18', lesson: allLessons.firstWhere((l) => l.name == 'Tarih'), name: 'Sanayi Devrimi'),

  // geography
  Subject(id: '19', lesson: allLessons.firstWhere((l) => l.name == 'Coğrafya'), name: 'İklim Tipleri'),
  Subject(id: '20', lesson: allLessons.firstWhere((l) => l.name == 'Coğrafya'), name: 'Yer Şekilleri'),
  Subject(id: '21', lesson: allLessons.firstWhere((l) => l.name == 'Coğrafya'), name: 'Nüfus ve Göç'),

  // philosophy
  Subject(id: '22', lesson: allLessons.firstWhere((l) => l.name == 'Felsefe'), name: 'Bilgi Felsefesi'),
  Subject(id: '23', lesson: allLessons.firstWhere((l) => l.name == 'Felsefe'), name: 'Ahlak Felsefesi'),
  Subject(id: '24', lesson: allLessons.firstWhere((l) => l.name == 'Felsefe'), name: 'Varlık Felsefesi'),

  // religion
  Subject(id: '25', lesson: allLessons.firstWhere((l) => l.name == 'Din Kültürü ve Ahlak Bilgisi'), name: 'İslam’ın Temel İlkeleri'),
  Subject(id: '26', lesson: allLessons.firstWhere((l) => l.name == 'Din Kültürü ve Ahlak Bilgisi'), name: 'Peygamberler Tarihi'),
  Subject(id: '27', lesson: allLessons.firstWhere((l) => l.name == 'Din Kültürü ve Ahlak Bilgisi'), name: 'Din ve Ahlak'),

  // turkish
  Subject(id: '28', lesson: allLessons.firstWhere((l) => l.name == 'Türkçe'), name: 'Fiilimsiler'),
  Subject(id: '29', lesson: allLessons.firstWhere((l) => l.name == 'Türkçe'), name: 'Cümlenin Ögeleri'),
  Subject(id: '30', lesson: allLessons.firstWhere((l) => l.name == 'Türkçe'), name: 'Anlatım Bozuklukları'),

  // english
  Subject(id: '31', lesson: allLessons.firstWhere((l) => l.name == 'İngilizce'), name: 'Tenses'),
  Subject(id: '32', lesson: allLessons.firstWhere((l) => l.name == 'İngilizce'), name: 'Modal Verbs'),
  Subject(id: '33', lesson: allLessons.firstWhere((l) => l.name == 'İngilizce'), name: 'Passive Voice'),
];