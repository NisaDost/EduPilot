import 'package:edupilot/models/quiz/lesson.dart';

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
  Subject(id: '1', lesson: Lesson.math, name: 'Köklü Sayılar'),
  Subject(id: '2', lesson: Lesson.math, name: 'Türev'),
  Subject(id: '3', lesson: Lesson.math, name: 'Integral'),

  // geometry
  Subject(id: '4', lesson: Lesson.geometry, name: 'Üçgenler'),
  Subject(id: '5', lesson: Lesson.geometry, name: 'Prizmalar'),
  Subject(id: '6', lesson: Lesson.geometry, name: 'Çemberler'),

  // physics
  Subject(id: '7', lesson: Lesson.physics, name: 'Newton Hareket Yasaları'),
  Subject(id: '8', lesson: Lesson.physics, name: 'Elektrik ve Manyetizma'),
  Subject(id: '9', lesson: Lesson.physics, name: 'Optik'),

  // chemistry
  Subject(id: '10', lesson: Lesson.chemistry, name: 'Periyodik Tablo'),
  Subject(id: '11', lesson: Lesson.chemistry, name: 'Asitler ve Bazlar'),
  Subject(id: '12', lesson: Lesson.chemistry, name: 'Kimyasal Tepkimeler'),

  // biology
  Subject(id: '13', lesson: Lesson.biology, name: 'Hücre Yapısı'),
  Subject(id: '14', lesson: Lesson.biology, name: 'Genetik ve Kalıtım'),
  Subject(id: '15', lesson: Lesson.biology, name: 'Fotosentez'),

  // history
  Subject(id: '16', lesson: Lesson.history, name: 'Osmanlı Tarihi'),
  Subject(id: '17', lesson: Lesson.history, name: 'Türk İnkılabı'),
  Subject(id: '18', lesson: Lesson.history, name: 'Sanayi Devrimi'),

  // geography
  Subject(id: '19', lesson: Lesson.geography, name: 'İklim Tipleri'),
  Subject(id: '20', lesson: Lesson.geography, name: 'Yer Şekilleri'),
  Subject(id: '21', lesson: Lesson.geography, name: 'Nüfus ve Göç'),

  // philosophy
  Subject(id: '22', lesson: Lesson.philosophy, name: 'Bilgi Felsefesi'),
  Subject(id: '23', lesson: Lesson.philosophy, name: 'Ahlak Felsefesi'),
  Subject(id: '24', lesson: Lesson.philosophy, name: 'Varlık Felsefesi'),

  // religion
  Subject(id: '25', lesson: Lesson.religion, name: 'İslam’ın Temel İlkeleri'),
  Subject(id: '26', lesson: Lesson.religion, name: 'Peygamberler Tarihi'),
  Subject(id: '27', lesson: Lesson.religion, name: 'Din ve Ahlak'),

  // turkish
  Subject(id: '28', lesson: Lesson.turkish, name: 'Fiilimsiler'),
  Subject(id: '29', lesson: Lesson.turkish, name: 'Cümlenin Ögeleri'),
  Subject(id: '30', lesson: Lesson.turkish, name: 'Anlatım Bozuklukları'),

  // english
  Subject(id: '31', lesson: Lesson.english, name: 'Tenses'),
  Subject(id: '32', lesson: Lesson.english, name: 'Modal Verbs'),
  Subject(id: '33', lesson: Lesson.english, name: 'Passive Voice'),
];