import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vahanar_front/config/api_config.dart';
import '../models/user_model.dart';

class AuthService {
  final storage = const FlutterSecureStorage();

  // Vérifier si l'utilisateur est connecté
  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: 'auth_token');
    return token != null;
  }

  // Récupérer l'utilisateur actuel
  Future<User?> getCurrentUser() async {
    final token = await storage.read(key: 'auth_token');
    if (token == null) return null;

    final response = await http.get(
      Uri.parse(ApiConfig.baseUrl + ApiConfig.userProfile),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(jsonDecode(response.body)['error'] ?? 'Failed to load user profile');
    }
  }

  // Inscription
  Future<User> register(
    String email,
    String password, {
    String? firstName,
    String? lastName,
    String? phoneNumber,
  }) async {
    final response = await http.post(
      Uri.parse(ApiConfig.baseUrl + ApiConfig.register),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      await storage.write(key: 'auth_token', value: token);
      return User.fromJson(data['user']);
    } else {
      throw Exception(jsonDecode(response.body)['error'] ?? 'Failed to register');
    }
  }

  // Connexion
  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiConfig.baseUrl + ApiConfig.login),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      await storage.write(key: 'auth_token', value: token);
      return User.fromJson(data['user']);
    } else {
      throw Exception(jsonDecode(response.body)['error'] ?? 'Failed to login');
    }
  }

  // Mot de passe oublié
  Future<void> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse(ApiConfig.baseUrl + ApiConfig.forgotPassword),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)['error'] ?? 'Failed to send reset email');
    }
  }

  // Vérification du téléphone
  Future<User> verifyPhone(String code) async {
    final token = await storage.read(key: 'auth_token');
    if (token == null) throw Exception('No user logged in');

    final response = await http.post(
      Uri.parse(ApiConfig.baseUrl + ApiConfig.verifyPhone),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'code': code,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(jsonDecode(response.body)['error'] ?? 'Failed to verify phone');
    }
  }

  // Déconnexion
  Future<void> logout() async {
    await storage.delete(key: 'auth_token');
  }
}