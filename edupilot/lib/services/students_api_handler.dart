import 'dart:convert';
import 'package:edupilot/models/dtos/favorite_lesson_dto.dart';
import 'package:edupilot/models/dtos/lessons_by_grade_dto.dart';
import 'package:edupilot/models/dtos/solved_question_count_dto.dart';
import 'package:edupilot/models/dtos/student_dto.dart';
import 'package:edupilot/models/dtos/weak_subjects_dto.dart';
import 'package:edupilot/sessions/student_session.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:http/io_client.dart';

class StudentsApiHandler {
  final String baseUrl = 'https://edupilot-api.azurewebsites.net/api';
  final String authUsername = 'admin';
  final String authPassword = 'password';

  late http.Client client;

  StudentsApiHandler() {
    // Create a custom client that ignores bad certificates
    final ioc = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    client = IOClient(ioc);
  }

  Future<StudentDTO> getStudent(String studentId) async {
    final student = await client.get(
      Uri.parse('$baseUrl/students/$studentId'),
      headers: <String, String>{
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (student.statusCode >= 200 && student.statusCode < 300) {
      StudentDTO studentBody = StudentDTO.fromJson(jsonDecode(student.body));
      return studentBody;
    } else {
      throw Exception('Failed to load data');
    }
  }
  
  Future<StudentDTO> getLoggedInStudent() async {
    final studentId = await StudentSession.getStudentId();
    final student = await client.get(
      Uri.parse('$baseUrl/students/$studentId'),
      headers: <String, String>{
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (student.statusCode >= 200 && student.statusCode < 300) {
      StudentDTO studentBody = StudentDTO.fromJson(jsonDecode(student.body));
      return studentBody;
    } else {
      throw Exception('Failed to load data');
    }
  }

  // same way: use client.post instead of http.post
  Future<bool> loginStudent(String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: <String, String>{
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      StudentSession.saveStudentId(response.body);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> registerStudent(
      String firstName,
      String? middleName,
      String lastName,
      int grade,
      String email,
      String password,
      String phoneNumber,
      String avatar,
      List<String> favLessonIds,
      String? supervisorName,
      int? supervisorUniqueCode,
  ) async {
    final response = await client.post(
      Uri.parse('$baseUrl/students/register'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'grade': grade,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'avatar': avatar,
        'favoriteLessons': favLessonIds,
        'supervisorUniqueCode': supervisorUniqueCode,
        'supervisorName': supervisorName,
      }),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {  
      return true;
    } else {
      throw Exception('Failed to register student');
    }
  }

  Future<List<FavoriteLessonDTO>> getFavoriteLessons() async {
    final studentId = await StudentSession.getStudentId();
    final lessons = await client.get(
      Uri.parse('$baseUrl/students/$studentId/favoritelessons'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (lessons.statusCode >= 200 && lessons.statusCode < 300) {
      List<dynamic> jsonResponse = jsonDecode(lessons.body);
      return jsonResponse
          .map((lesson) => FavoriteLessonDTO.fromJson(lesson))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<LessonsByGradeDTO>> getNotFavLessons() async {
    final student = await StudentsApiHandler().getLoggedInStudent();
    
    final allLessonsResponse = await client.get(
      Uri.parse('$baseUrl/lessons/${student.grade}'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final allLessons = jsonDecode(allLessonsResponse.body) as List<dynamic>;
    final favLessonsResponse = await client.get(
      Uri.parse('$baseUrl/students/${student.studentId}/favoritelessons'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final favLessons = jsonDecode(favLessonsResponse.body) as List<dynamic>;

    final notFavLessons = allLessons.where((lessonId)  => 
        !favLessons.any((favLesson) => favLesson['lessonId'] == lessonId['id'])).toList();

    if (notFavLessons.isNotEmpty) {
      return notFavLessons
          .map((lesson) => LessonsByGradeDTO.fromJson(lesson))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<bool> updateFavoriteLessons(List<String> lessonIds) async {
    final studentId = await StudentSession.getStudentId();
    final response = await client.put(
      Uri.parse('$baseUrl/students/$studentId/favoritelessons'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, List<String>>{
        'lessonIds': lessonIds,
      }),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      throw Exception('Failed to update favorite lessons');
    }
  }

  Future<bool> updateAvatar(String avatar) async {
    final studentId = await StudentSession.getStudentId();
    final response = await client.put(
      Uri.parse('$baseUrl/students/$studentId/avatar'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'avatar': avatar,
      }),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      throw Exception('Failed to update avatar');
    }
  }

  Future<bool> addSupervisor(String supervisorName, int supervisorUniqueCode) async {
    final studentId = await StudentSession.getStudentId();
    final response = await client.post(
      Uri.parse('$baseUrl/students/$studentId/supervisor'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'supervisorUniqueCode': supervisorUniqueCode,
        'supervisorName': supervisorName,
      }),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<SolvedQuestionCountDTO>> getSolvedQuestionCountPerWeek(DateTime startOfWeek, DateTime endOfWeek) async {
    final studentId = await StudentSession.getStudentId();
    final response = await client.get(
      Uri.parse('$baseUrl/students/$studentId/solvedquestioncount/$startOfWeek/$endOfWeek'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((questionCount) => SolvedQuestionCountDTO.fromJson(questionCount))
          .toList();
    } else {
      throw Exception('Failed to get solved question count data');
    }
  }

  Future<List<SolvedQuestionCountDTO>> getSolvedQuestionCountForDay(DateTime date) async {
    final studentId = await StudentSession.getStudentId();
    final response = await client.get(
      Uri.parse('$baseUrl/students/$studentId/solvedquestioncount/$date'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((item) => SolvedQuestionCountDTO.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to fetch daily lesson data');
    }
  }

  Future<bool> postSolvedQuestionCountPerLesson(int count, String lessonId, DateTime date) async {
    final studentId = await StudentSession.getStudentId();
    final response = await client.post(
      Uri.parse('$baseUrl/students/$studentId/add/questioncount/$count/lesson/$lessonId/date/$date'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'studentId': studentId,
        'lessonId': lessonId,
        'count': count,
      })
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<WeakSubjectsDTO>> getWeakSubjects() async {
    final studentId = await StudentSession.getStudentId();
    final response = await client.get(
      Uri.parse('$baseUrl/students/$studentId/weaksubjects'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((item) => WeakSubjectsDTO.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to fetch weak subjects');
    }
  }
}