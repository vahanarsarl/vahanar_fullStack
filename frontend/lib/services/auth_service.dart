import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vahanar_front/utils/validators.dart';

class AuthService {
  static const String baseUrl = "http://192.182.209.128/pages/api/auth";

  Future<Map<String, dynamic>> registerUser({
    required String fullName,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      // Validate inputs first
      Validators.validateEmail(email);
      Validators.validatePassword(password);
      Validators.validatePhoneNumber(phone);

      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': fullName,
          'phone': phone,
          'email': email,
          'password': password,
        }),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return responseBody;
      } else if (response.statusCode == 400) {
        throw Exception('Bad request: ${responseBody['message']}');
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: ${responseBody['message']}');
      } else if (response.statusCode == 500) {
        throw Exception('Server error: ${responseBody['message']}');
      } else {
        throw Exception(responseBody['message'] ?? 'Registration failed');
      }
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Registration error: $e');
    }
  }

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return responseBody;
      } else if (response.statusCode == 400) {
        throw Exception('Bad request: ${responseBody['message']}');
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: ${responseBody['message']}');
      } else if (response.statusCode == 500) {
        throw Exception('Server error: ${responseBody['message']}');
      } else {
        throw Exception(responseBody['message'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }
}
