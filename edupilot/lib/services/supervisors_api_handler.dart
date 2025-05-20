
import 'dart:convert';

import 'package:edupilot/models/dtos/supervisor_dto.dart';
import 'package:edupilot/models/dtos/supervisor_info_dto.dart';
import 'package:edupilot/models/dtos/supervisor_register_dto.dart';
import 'package:edupilot/sessions/supervisor_session.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:http/io_client.dart';

class SupervisorsApiHandler {
  final String baseUrl = 'https://edupilot-api.azurewebsites.net/api';
  final String authUsername = 'admin';
  final String authPassword = 'password';

  late http.Client client;

  SupervisorsApiHandler() {
    // Create a custom client that ignores bad certificates
    final ioc = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    client = IOClient(ioc);
  }

  Future<SupervisorDTO> getSupervisor() async {
    final supervisorId = await SupervisorSession.getSupervisorId();
    final supervisor = await client.get(
      Uri.parse('$baseUrl/supervisors/$supervisorId'),
      headers: <String, String>{
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (supervisor.statusCode >= 200 && supervisor.statusCode < 300) {
      SupervisorDTO supervisorBody = SupervisorDTO.fromJson(jsonDecode(supervisor.body));
      return supervisorBody;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<bool> registerSupervisor(SupervisorRegisterDTO supervisor) async {
    final response = await client.post(
      Uri.parse('$baseUrl/supervisors/register'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'firstName': supervisor.firstName,
        'middleName': supervisor.middleName,
        'lastName': supervisor.lastName,
        'email': supervisor.email,
        'password': supervisor.password,
        'phoneNumber': supervisor.phoneNumber,
      }),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {  
      return true;
    } else {
      throw Exception('Failed to register supervisor');
    }
  }

  Future<bool> loginSupervisor(String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/login/supervisor'),
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
      SupervisorSession.saveSupervisorId(response.body);
      return true;
    } else {
      return false;
    }
  }

  Future<SupervisorInfoDTO> getSupervisorInfo() async {
    final supervisorId = await SupervisorSession.getSupervisorId();
    final supervisor = await client.get(
      Uri.parse('$baseUrl/supervisors/$supervisorId/info'),
      headers: <String, String>{
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (supervisor.statusCode >= 200 && supervisor.statusCode < 300) {
      SupervisorInfoDTO supervisorBody = SupervisorInfoDTO.fromJson(jsonDecode(supervisor.body));
      return supervisorBody;
    } else {
      throw Exception('Failed to load data');
    }
  }
}