import 'dart:convert';
import 'package:edupilot/models/dtos/answer_dto.dart';
import 'package:edupilot/models/dtos/quiz_dto.dart';
import 'package:edupilot/models/dtos/quiz_info_dto.dart';
import 'package:edupilot/models/dtos/quiz_result_dto.dart';
import 'package:edupilot/models/dtos/solved_quiz_dto.dart';
import 'package:edupilot/sessions/student_session.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:http/io_client.dart';

class QuizzesApiHandler {
  final String baseUrl = 'https://edupilot-api.azurewebsites.net/api';
  final String authUsername = 'admin';
  final String authPassword = 'password';

  late http.Client client;

  QuizzesApiHandler() {
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
      final jsonResponse = jsonDecode(quizzes.body);
      return QuizDTO.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<QuizInfoDTO> getQuizInfo(String quizId) async {
    final quizInfo = await client.get(
      Uri.parse('$baseUrl/quizinfo/$quizId'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',  
      },
    );
    if (quizInfo.statusCode >= 200 && quizInfo.statusCode < 300) {
      final jsonResponse = jsonDecode(quizInfo.body);
      return QuizInfoDTO.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<QuizDTO> getQuiz(String quizId) async {
    final quiz = await client.get(
      Uri.parse('$baseUrl/quiz/$quizId'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',  
      },
    );
    if (quiz.statusCode >= 200 && quiz.statusCode < 300) {
      final jsonResponse = jsonDecode(quiz.body);
      return QuizDTO.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<QuizResultDTO> postQuizResult(String quizId, List<AnswerDTO> answers) async {
    final studentId = await StudentSession.getStudentId();

    final List<Map<String, dynamic>> answersBody = [
      for (final quizAnswer in answers) {
        'questionId': quizAnswer.questionId,
        'choiceId': quizAnswer.choiceId,
      }
    ];

    final response = await client.post(
      Uri.parse('$baseUrl/quiz/$quizId/student/$studentId'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',  
      },
      body: jsonEncode(answersBody),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body);
      return QuizResultDTO.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to register student');
    }
  }

  Future<SolvedQuizDTO> getSolvedQuiz(String quizId) async {
    final studentId = await StudentSession.getStudentId();
    final quiz = await client.get(
      Uri.parse('$baseUrl/quiz/$quizId/student/$studentId'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',  
      },
    );
    if (quiz.statusCode >= 200 && quiz.statusCode < 300) {
      final jsonResponse = jsonDecode(quiz.body);
      return SolvedQuizDTO.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
