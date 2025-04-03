import 'package:edupilot/models/quiz/lesson.dart';

class Subject {

  final String id;
  final Lesson lesson;
  final String name;
  final bool isActive;

  Subject({
    required this.id,
    required this.lesson,
    required this.name,
    required this.isActive,
  });
}

final List<Subject> allSubjects = [
  // math
  Subject(id: '1', lesson: Lesson.math, name: 'Köklü Sayılar', isActive: true),
  Subject(id: '2', lesson: Lesson.math, name: 'Türev', isActive: true),
  Subject(id: '3', lesson: Lesson.math, name: 'Integral', isActive: true),

  // geometry
  Subject(id: '4', lesson: Lesson.geometry, name: 'Üçgenler', isActive: true),
  Subject(id: '5', lesson: Lesson.geometry, name: 'Prizmalar', isActive: true),
  Subject(id: '6', lesson: Lesson.geometry, name: 'Çemberler', isActive: true),

  // physics
  Subject(id: '7', lesson: Lesson.physics, name: 'Newton Hareket Yasaları', isActive: true),
  Subject(id: '8', lesson: Lesson.physics, name: 'Elektrik ve Manyetizma', isActive: true),
  Subject(id: '9', lesson: Lesson.physics, name: 'Optik', isActive: true),

  // chemistry
  Subject(id: '10', lesson: Lesson.chemistry, name: 'Periyodik Tablo', isActive: true),
  Subject(id: '11', lesson: Lesson.chemistry, name: 'Asitler ve Bazlar', isActive: true),
  Subject(id: '12', lesson: Lesson.chemistry, name: 'Kimyasal Tepkimeler', isActive: true),

  // biology
  Subject(id: '13', lesson: Lesson.biology, name: 'Hücre Yapısı', isActive: true),
  Subject(id: '14', lesson: Lesson.biology, name: 'Genetik ve Kalıtım', isActive: true),
  Subject(id: '15', lesson: Lesson.biology, name: 'Fotosentez', isActive: true),

  // history
  Subject(id: '16', lesson: Lesson.history, name: 'Osmanlı Tarihi', isActive: true),
  Subject(id: '17', lesson: Lesson.history, name: 'Türk İnkılabı', isActive: true),
  Subject(id: '18', lesson: Lesson.history, name: 'Sanayi Devrimi', isActive: true),

  // geography
  Subject(id: '19', lesson: Lesson.geography, name: 'İklim Tipleri', isActive: true),
  Subject(id: '20', lesson: Lesson.geography, name: 'Yer Şekilleri', isActive: true),
  Subject(id: '21', lesson: Lesson.geography, name: 'Nüfus ve Göç', isActive: true),

  // philosophy
  Subject(id: '22', lesson: Lesson.philosophy, name: 'Bilgi Felsefesi', isActive: true),
  Subject(id: '23', lesson: Lesson.philosophy, name: 'Ahlak Felsefesi', isActive: true),
  Subject(id: '24', lesson: Lesson.philosophy, name: 'Varlık Felsefesi', isActive: true),

  // religion
  Subject(id: '25', lesson: Lesson.religion, name: 'İslam’ın Temel İlkeleri', isActive: true),
  Subject(id: '26', lesson: Lesson.religion, name: 'Peygamberler Tarihi', isActive: true),
  Subject(id: '27', lesson: Lesson.religion, name: 'Din ve Ahlak', isActive: true),

  // turkish
  Subject(id: '28', lesson: Lesson.turkish, name: 'Fiilimsiler', isActive: true),
  Subject(id: '29', lesson: Lesson.turkish, name: 'Cümlenin Ögeleri', isActive: true),
  Subject(id: '30', lesson: Lesson.turkish, name: 'Anlatım Bozuklukları', isActive: true),

  // english
  Subject(id: '31', lesson: Lesson.english, name: 'Tenses', isActive: true),
  Subject(id: '32', lesson: Lesson.english, name: 'Modal Verbs', isActive: true),
  Subject(id: '33', lesson: Lesson.english, name: 'Passive Voice', isActive: true),
];