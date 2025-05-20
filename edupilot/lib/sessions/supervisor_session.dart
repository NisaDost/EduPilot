import 'package:shared_preferences/shared_preferences.dart';

class SupervisorSession {
  static const String _keySupervisorId = 'supervisorId';

  static Future<void> saveSupervisorId(String supervisorId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keySupervisorId, supervisorId);
  }

  static Future<String?> getSupervisorId() async {
    final prefs = await SharedPreferences.getInstance();
    String? supervisorId = prefs.getString(_keySupervisorId);
    return supervisorId?.replaceAll('"', '').trim();
  }

  static Future<void> clearSupervisorId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keySupervisorId);
  }
}