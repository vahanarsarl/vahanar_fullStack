import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vahanar_front/config/api_config.dart';
import '../models/user_model.dart';

class UserService {
  final storage = const FlutterSecureStorage();

  // Get user profile
  Future<User> getUserProfile() async {
    final token = await storage.read(key: 'auth_token');

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

  // Update user profile
  Future<User> updateUserProfile({String? firstName, String? lastName, String? phoneNumber}) async {
    final token = await storage.read(key: 'auth_token');

    final response = await http.patch(
      Uri.parse(ApiConfig.baseUrl + ApiConfig.userProfile),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        if (firstName != null) 'firstName': firstName,
        if (lastName != null) 'lastName': lastName,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(jsonDecode(response.body)['error'] ?? 'Failed to update profile');
    }
  }
}