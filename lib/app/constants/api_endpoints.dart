class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "user/login";
  static const String register = "user/register";
  static const String logout = "user/logout";
  static const String getUserProfile = "user/profile";
  static const String updateProfile = "user/profile/update";

  // Profile Image Upload (This is the same route as updateProfile)
  static const String uploadImage =
      "user/profile/update"; // Using updateProfile endpoint for image upload
}
