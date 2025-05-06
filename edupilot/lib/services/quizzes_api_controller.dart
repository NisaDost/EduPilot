import 'dart:convert';
import 'package:edupilot/models/dtos/quiz_dto.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:http/io_client.dart';

class QuizzesApiController {
  final String baseUrl = 'https://10.0.2.2:7104/api';
  final String authUsername = 'admin';
  final String authPassword = 'password';

  late http.Client client;

  QuizzesApiController() {
    // Create a custom client that ignores bad certificates
    final ioc = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    client = IOClient(ioc);
  }

  Future<QuizDTO> getQuizzesBySubjectId(String subjectId) async {
    final quizzes = await client.get(
      Uri.parse('$baseUrl/quizzes/subject/$subjectId'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',  
      },
    );
    if (quizzes.statusCode >= 200 && quizzes.statusCode < 300) {
      Map<String, dynamic> jsonResponse = jsonDecode(quizzes.body);
      return QuizDTO.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
