import 'package:shared_preferences/shared_preferences.dart';

class StudentSession {
  static const String _keyStudentId = 'studentId';

  static Future<void> saveStudentId(String studentId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyStudentId, studentId);
  }

  static Future<String?> getStudentId() async {
    final prefs = await SharedPreferences.getInstance();
    String? studentId = prefs.getString(_keyStudentId);
    return studentId?.replaceAll('"', '').trim();
  }

  static Future<void> clearStudentId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyStudentId);
  }
}