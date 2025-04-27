import 'dart:convert';
import 'package:edupilot/models/dtos/favorite_lesson_dto.dart';
import 'package:edupilot/models/dtos/student_dto.dart';
import 'package:edupilot/sessions/student_session.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:http/io_client.dart';

class StudentsApiHandler {
  final String baseUrl = 'https://10.0.2.2:7104/api';
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
      Uri.parse('$baseUrl/$studentId'),
      headers: <String, String>{
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (student.statusCode == 200) {
      return StudentDTO.fromJson(jsonDecode(student.body));
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

    if (response.statusCode == 200) {
      StudentSession.saveStudentId(response.body);
      return true;
    } else {
      return false;
    }
  }

  // same for registerStudent and getFavoriteLessons: use client.post and client.get
  Future<dynamic> registerStudent(
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
        'favLessonIds': favLessonIds,
        'supervisorName': supervisorName,
        'supervisorUniqueCode': supervisorUniqueCode,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      return jsonDecode(response.body);
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
    if (lessons.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(lessons.body);
      return jsonResponse
          .map((lesson) => FavoriteLessonDTO.fromJson(lesson))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  } 
}