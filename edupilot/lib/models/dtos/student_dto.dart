import 'package:edupilot/models/dtos/favorite_lesson_dto.dart';
import 'package:edupilot/models/dtos/student_achievement_dto.dart';
import 'package:edupilot/models/dtos/student_supervisor_dto.dart';

class StudentDTO {
  final String studentId;
  final String firstName;
  final String? middleName;
  final String lastName;
  final int grade;
  final String avatar;
  final int dailyStreakCount;
  final int points;
  final String? institutionName;
  final List<FavoriteLessonDTO>? favoriteLessons;
  final List<StudentAchievementDTO>? studentAchievements;
  final List<StudentSupervisorDTO>? studentSupervisors;

  const StudentDTO({
    required this.studentId,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.grade,
    required this.avatar,
    required this.points,
    required this.dailyStreakCount,
    this.institutionName,
    required this.favoriteLessons,
    this.studentSupervisors,
    required this.studentAchievements,
  });

  factory StudentDTO.fromJson(Map<String, dynamic> json) => StudentDTO(
        studentId: json['studentId'] as String,
        firstName: json['firstName'] as String,
        middleName: json['middleName'] as String?,
        lastName: json['lastName'] as String,
        grade: json['grade'] as int,
        avatar: json['avatar'] as String,
        points: json['points'] as int,
        dailyStreakCount: json['dailyStreakCount'] as int,
        institutionName: json['institutionName'] as String?,
        favoriteLessons: (json['favoriteLessons'] as List<dynamic>?)
            ?.map((e) => FavoriteLessonDTO.fromJson(e))
            .toList(),
        studentAchievements: (json['studentAchievements'] as List<dynamic>?)
            ?.map((e) => StudentAchievementDTO.fromJson(e))
            .toList(),
        studentSupervisors: (json['studentSupervisors'] as List<dynamic>?)
            ?.map((e) => StudentSupervisorDTO.fromJson(e))
            .toList(),
      );
      
  Map<String, dynamic> toJson() => {
        'studentId': studentId,
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'grade': grade,
        'avatar': avatar,
        'points': points,
        'dailyStreakCount': dailyStreakCount,
        'institutionName': institutionName,
        'favoriteLessons': favoriteLessons?.map((e) => e.toJson()).toList(),
        'dtudentAchievements':
            studentAchievements?.map((e) => e.toJson()).toList(),
        'studentSupervisors':
            studentSupervisors?.map((e) => e.toJson()).toList(),
      };
}
