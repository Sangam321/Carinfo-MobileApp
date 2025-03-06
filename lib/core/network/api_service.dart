import 'package:carinfo/app/constants/api_endpoints.dart';
import 'package:carinfo/core/common/internet_checker/internet_checker.dart'; // Import your InternetChecker class
import 'package:carinfo/core/network/dio_error_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart'; // If using SharedPreferences for storing token

class ApiService {
  final Dio _dio;
  final InternetChecker _internetChecker; // Reference to the InternetChecker

  Dio get dio => _dio;

  // Constructor
  ApiService(this._dio, this._internetChecker) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(DioErrorInterceptor()) // Custom error handling
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true))
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

    // Add an interceptor to add the Authorization header if a token exists
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString(
            'token'); // Assuming the JWT is saved in shared preferences
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options); // Continue request
      },
    ));
  }

  // Helper function to check internet connection before making requests
  Future<bool> _checkInternetConnection() async {
    bool isConnected = await _internetChecker.isConnected();
    return isConnected;
  }

  // GET request method with internet check
  Future<Response?> getRequest(String endpoint) async {
    bool isConnected = await _checkInternetConnection();

    if (!isConnected) {
      throw Exception("No internet connection. Please try again later.");
    }

    try {
      return await _dio.get(endpoint);
    } catch (e) {
      rethrow; // Rethrow any errors after checking for internet
    }
  }

  // POST request method with internet check
  Future<Response?> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    bool isConnected = await _checkInternetConnection();

    if (!isConnected) {
      throw Exception("No internet connection. Please try again later.");
    }

    try {
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      rethrow; // Rethrow any errors after checking for internet
    }
  }

  // PUT request method with internet check
  Future<Response?> putRequest(
      String endpoint, Map<String, dynamic> data) async {
    bool isConnected = await _checkInternetConnection();

    if (!isConnected) {
      throw Exception("No internet connection. Please try again later.");
    }

    try {
      return await _dio.put(endpoint, data: data);
    } catch (e) {
      rethrow; // Rethrow any errors after checking for internet
    }
  }

  // DELETE request method with internet check
  Future<Response?> deleteRequest(String endpoint) async {
    bool isConnected = await _checkInternetConnection();

    if (!isConnected) {
      throw Exception("No internet connection. Please try again later.");
    }

    try {
      return await _dio.delete(endpoint);
    } catch (e) {
      rethrow; // Rethrow any errors after checking for internet
    }
  }
}
