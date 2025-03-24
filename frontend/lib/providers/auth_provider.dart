import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;

  // Initialize the provider
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      final isLoggedIn = await _authService.isLoggedIn();
      if (isLoggedIn) {
        _user = await _authService.getCurrentUser();
      }
    } catch (e) {
      print('Error initializing auth provider: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Register user
  Future<void> register(String email, String password, {String? firstName, String? lastName, String? phoneNumber}) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _authService.register(
        email, 
        password,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
      );
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login user
  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _authService.login(email, password);
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Forgot password
  Future<void> forgotPassword(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.forgotPassword(email);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Verify phone
  Future<void> verifyPhone(String code) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _authService.verifyPhone(code);
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.logout();
      _user = null;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}