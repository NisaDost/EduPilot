import 'dart:convert';
import 'package:edupilot/models/dtos/coupon_dto.dart';
import 'package:edupilot/models/dtos/lessons_by_grade_dto.dart';
import 'package:edupilot/models/dtos/subject_dto.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/sessions/student_session.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:http/io_client.dart';

class CouponsApiHandler {
  final String baseUrl = 'https://10.0.2.2:7104/api';
  final String authUsername = 'admin';
  final String authPassword = 'password';

  late http.Client client;

  CouponsApiHandler() {
    // Create a custom client that ignores bad certificates
    final ioc = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    client = IOClient(ioc);
  }

  Future<List<CouponDTO>> getActiveCoupons() async {
    final coupons = await client.get(
      Uri.parse('$baseUrl/coupon/active'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('$authUsername:$authPassword'))}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (coupons.statusCode >= 200 && coupons.statusCode < 300) {
      List<dynamic> jsonResponse = jsonDecode(coupons.body);
      return jsonResponse
          .map((coupon) => CouponDTO.fromJson(coupon))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}