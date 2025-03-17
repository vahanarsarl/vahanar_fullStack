import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vahanar/utils/validators.dart';

class AuthService {
  static const String baseUrl = "http://your-domain.com/api/auth";

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
          'password': password
        }),
      );

      final responseBody = jsonDecode(response.body);
      
      if (response.statusCode == 201) {
        return responseBody;
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
      } else {
        throw Exception(responseBody['message'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }
}
