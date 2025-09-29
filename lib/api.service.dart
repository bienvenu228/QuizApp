import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.0.212:8000/api';

  /// Login ou création d'utilisateur
  /// Si le nom est fourni, la création sera tentée
  static Future<Map<String, dynamic>?> login(String email, {String? name}) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          if (name != null) 'name': name,
        }),
      );

      // Status 200 / 201 → OK
      if (res.statusCode == 200 || res.statusCode == 201) {
        return jsonDecode(res.body);
      }

      // Cas 422 → nom requis pour création
      if (res.statusCode == 422) {
        return jsonDecode(res.body);
      }

      print('Erreur API: Status ${res.statusCode}');
      return null;
    } catch (e) {
      print('Erreur API: $e');
      return null;
    }
  }
  Future<List> getPhases(String token) async {
  final res = await http.get(
    Uri.parse('http://192.168.0.213:8000/api/phases'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (res.statusCode == 200) return jsonDecode(res.body);
  throw Exception('Erreur API Phases: ${res.statusCode}');
}

}
