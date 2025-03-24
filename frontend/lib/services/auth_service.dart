import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage';
import '../config/api_config.dart';
import '../models/user_model.dart';

class AuthService {
  final storage = const FlutterSecureStorage();
  
  // Register user
  Future<User> register(String email, String password, {String? firstName, String? lastName, String? phoneNumber}) async {
    final response = await http.post(
      Uri.parse(APIConfig.baseUrl + APIConfig.register),
      headers: {'Content-Type': 'application/json'},
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
      // Save the token
      await storage.write(key: 'auth_token', value: data['token']);
      return User.fromJson(data['user']);
    } else {
      throw Exception(jsonDecode(response.body)['error'] ?? 'Failed to register');
    }
  }
  
  // Login user
  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(APIConfig.baseUrl + APIConfig.login),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Save the token
      await storage.write(key: 'auth_token', value: data['token']);
      return User.fromJson(data['user']);
    } else {
      throw Exception(jsonDecode(response.body)['error'] ?? 'Failed to login');
    }
  }
  
  // Forgot password
  Future<void> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse(APIConfig.baseUrl + APIConfig.forgotPassword),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
      }),
    );
    
    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)['error'] ?? 'Failed to process request');
    }
  }
  
  // Verify phone
  Future<User> verifyPhone(String code) async {
    final token = await storage.read(key: 'auth_token');
    
    final response = await http.post(
      Uri.parse(APIConfig.baseUrl + APIConfig.verifyPhone),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'code': code,
      }),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data['user']);
    } else {
      throw Exception(jsonDecode(response.body)['error'] ?? 'Failed to verify phone');
    }
  }
  
  // Get current user
  Future<User?> getCurrentUser() async {
    final token = await storage.read(key: 'auth_token');
    if (token == null) {
      return null;
    }
    
    try {
      final response = await http.get(
        Uri.parse(APIConfig.baseUrl + APIConfig.userProfile),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }
  
  // Logout
  Future<void> logout() async {
    await storage.delete(key: 'auth_token');
  }
  
  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: 'auth_token');
    return token != null;
  }
}