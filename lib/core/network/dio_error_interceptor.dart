import 'package:dio/dio.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = 'An unexpected error occurred';
    int statusCode = err.response?.statusCode ??
        -1; // Default to -1 if no status code available

    if (err.response != null) {
      // Server-side errors (status code >= 300)
      if (err.response!.statusCode! >= 300) {
        errorMessage = err.response!.data['message'] ??
            err.response!.statusMessage ??
            'Something went wrong';
      } else {
        errorMessage = 'Unexpected response from server';
      }
    } else {
      // Client-side or connection errors
      if (err.type == DioExceptionType.connectionError) {
        errorMessage = 'Connection error: Unable to reach the server';
      } else if (err.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Server timeout error';
      } else if (err.type == DioExceptionType.sendTimeout) {
        errorMessage = 'Request timeout error';
      } else {
        errorMessage = 'An unknown error occurred';
      }
    }

    // Log or print error message for debugging purposes
    print('Dio Error: $errorMessage (Status Code: $statusCode)');

    // Modify the error object with a more detailed message
    err = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      error: errorMessage,
      type: err.type,
    );

    super.onError(err, handler);
  }
}
