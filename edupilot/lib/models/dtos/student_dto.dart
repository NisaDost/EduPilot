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
        studentId: json['StudentId'] as String,
        firstName: json['FirstName'] as String,
        middleName: json['MiddleName'] as String?,
        lastName: json['LastName'] as String,
        grade: json['Grade'] as int,
        avatar: json['Avatar'] as String,
        points: json['Points'] as int,
        dailyStreakCount: json['DailyStreakCount'] as int,
        institutionName: json['InstitutionName'] as String?,
        favoriteLessons: (json['FavoriteLessons'] as List<dynamic>?)
            ?.map((e) => FavoriteLessonDTO.fromJson(e))
            .toList(),
        studentAchievements: (json['StudentAchievements'] as List<dynamic>?)
            ?.map((e) => StudentAchievementDTO.fromJson(e))
            .toList(),
        studentSupervisors: (json['StudentSupervisors'] as List<dynamic>?)
            ?.map((e) => StudentSupervisorDTO.fromJson(e))
            .toList(),
      );
      
  Map<String, dynamic> toJson() => {
        'StudentId': studentId,
        'FirstName': firstName,
        'MiddleName': middleName,
        'LastName': lastName,
        'Grade': grade,
        'Avatar': avatar,
        'Points': points,
        'DailyStreakCount': dailyStreakCount,
        'InstitutionName': institutionName,
        'FavoriteLessons': favoriteLessons?.map((e) => e.toJson()).toList(),
        'StudentAchievements':
            studentAchievements?.map((e) => e.toJson()).toList(),
        'StudentSupervisors':
            studentSupervisors?.map((e) => e.toJson()).toList(),
      };
}
