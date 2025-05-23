import 'dart:convert';
import 'package:edupilot/models/dtos/lesson_name_dto.dart';
import 'package:edupilot/models/dtos/lessons_by_grade_dto.dart';
import 'package:edupilot/models/dtos/subject_dto.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/sessions/student_session.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:http/io_client.dart';

class LessonsApiHandler {
  final String baseUrl = 'https://edupilot-api.azurewebsites.net/api';
  final String authUsername = 'admin';
  final String authPassword = 'password';

  late http.Client client;

  LessonsApiHandler() {
    // Create a custom client that ignores bad certificates
    final ioc = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    client = IOClient(ioc);
  }

  Future<List<LessonsByGradeDTO>> getLessonsByGrade() async {
    final studentId = await StudentSession.getStudentId();
    if (studentId == null) {
      throw Exception('Student ID not found in session');
    }
    final student = await StudentsApiHandler().getLoggedInStudent();
    
    final lessons = await client.get(
      Uri.parse('$baseUrl/lessons/${student.grade}'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (lessons.statusCode >= 200 && lessons.statusCode < 300) {
      List<dynamic> jsonResponse = jsonDecode(lessons.body);
      return jsonResponse
          .map((lesson) => LessonsByGradeDTO.fromJson(lesson))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<LessonsByGradeDTO>> getLessonsByGradeForRegister(int grade) async {
    final lessons = await client.get(
      Uri.parse('$baseUrl/lessons/$grade'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (lessons.statusCode >= 200 && lessons.statusCode < 300) {
      List<dynamic> jsonResponse = jsonDecode(lessons.body);
      return jsonResponse
          .map((lesson) => LessonsByGradeDTO.fromJson(lesson))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<SubjectDTO>> getSubjectsByLessonId(String lessonId) async {
    final studentId = await StudentSession.getStudentId();
    final subjects = await client.get(
      Uri.parse('$baseUrl/lessons/$lessonId/subjects/student/$studentId'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (subjects.statusCode >= 200 && subjects.statusCode < 300) {
      List<dynamic> jsonResponse = jsonDecode(subjects.body);
      return jsonResponse
          .map((subject) => SubjectDTO.fromJson(subject))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<LessonNameDTO> getLessonNameFromSubjectId(String subjecId) async {
    final lesson = await client.get(
      Uri.parse('$baseUrl/lesson/subject/$subjecId'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (lesson.statusCode >= 200 && lesson.statusCode < 300) {
      final Map<String, dynamic> jsonResponse = jsonDecode(lesson.body);
      return LessonNameDTO.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }
}