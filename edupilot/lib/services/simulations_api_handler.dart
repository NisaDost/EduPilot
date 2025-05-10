import 'dart:convert';
import 'package:edupilot/models/dtos/simulation_dto.dart';
import 'package:edupilot/sessions/student_session.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:http/io_client.dart';

class SimulationsApiHandler {
  final String baseUrl = 'https://10.0.2.2:7104/api';
  final String authUsername = 'admin';
  final String authPassword = 'password';

  late http.Client client;

  SimulationsApiHandler() {
    // Create a custom client that ignores bad certificates
    final ioc = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    client = IOClient(ioc);
  }

  Future<List<SimulationDTO>> getSimulations() async {
    final response = await client.get(
      Uri.parse('$baseUrl/simulation'),
      headers: <String, String>{
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((simulation) => SimulationDTO.fromJson(simulation))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<bool> postStudiedSimulation(String id) async {
    final studentId = await StudentSession.getStudentId();
    if (studentId == null) {
      throw Exception('Student ID not found');
    }
    final response = await client.post(
      Uri.parse('$baseUrl/simulation/$id/student/$studentId'),
      headers: <String, String>{
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'id': id, 'studentId': studentId}),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      throw Exception('Failed to post data');
    }
  }
}