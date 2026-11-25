
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myportofolio_mobile/config.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ApiException implements Exception {
  const ApiException(this.statusCode, this.message);

  final int statusCode;
  final String message;

  @override
  String toString() => 'ApiException($statusCode): $message';
}


class ApiClient {
  static String get baseUrl => apiBaseUrl;

  // Mengambil daftar proyek
  static Future<List<Project>> getProjects() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/projects/'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Project.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data proyek');
    }
  }

  // Login dan mendapatkan token
  static Future<String> obtainToken(
    String username,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/token/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token'];
    } else {
      throw ApiException(response.statusCode, response.body);
    }
  }

  // Logout
  static Future<void> logout(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/logout/'),
      headers: {
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Logout gagal');
    }
  }

  // Menambahkan proyek
  static Future<void> createProject(
    Map<String, dynamic> projectData,
    String token,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/projects/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(projectData),
    );

    if (response.statusCode != 201) {
      throw Exception('Gagal menambahkan proyek: ${response.body}');
    }
  }
}
