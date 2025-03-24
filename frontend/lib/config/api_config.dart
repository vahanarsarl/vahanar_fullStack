class APIConfig {
  static const String baseUrl = 'https://your-backend-url.com/api';
  // Use for local development
  // static const String baseUrl = 'http://10.0.2.2:3000/api'; // For Android emulator
  // static const String baseUrl = 'http://localhost:3000/api'; // For iOS simulator
  
  // API endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyPhone = '/auth/verify';
  static const String userProfile = '/users/me';
  static const String products = '/products';
  static const String bookings = '/bookings';
}