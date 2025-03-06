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

  // ====================== Car Routes ======================
  static const String getAllCars = "cars"; // Route to get all cars
  static const String getCarById =
      "cars/{id}"; // Route to get car by ID (ID will be dynamic)
  static const String addCar = "cars"; // Route to add a new car
  static const String updateCar =
      "cars/{id}"; // Route to update car details by ID
  static const String deleteCar = "cars/{id}"; // Route to delete a car by ID
}
