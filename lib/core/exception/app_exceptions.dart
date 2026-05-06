import 'package:dio/dio.dart';

class AppException implements Exception {
  AppException({required this.errorMessage});

  AppException.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        errorMessage = 'Request to the server was cancelled.';
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timed out.';
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receiving timeout occurred.';
      case DioExceptionType.sendTimeout:
        errorMessage = 'Request send timeout.';
      case DioExceptionType.badResponse:
        errorMessage = _handleStatusCode(
          dioError.response! as Response<Map<String, String>>,
        );
      case DioExceptionType.badCertificate:
        errorMessage = 'Bad certificate received.';
      case DioExceptionType.connectionError:
        errorMessage = 'Connection error occurred.';
      case DioExceptionType.unknown:
        if (dioError.message != null &&
            dioError.message!.contains('SocketException')) {
          errorMessage = 'No Internet connection.';
        } else {
          errorMessage = 'Unexpected error occurred.';
        }
    }
  }

  late String errorMessage;

  String _handleStatusCode(Response<Map<String, String>> response) {
    switch (response.statusCode) {
      case 400:
        return response.data?['message'] ?? 'Bad request.';
      case 401:
        return 'Authentication failed.';
      case 403:
        return response.data?['message'] ??
            'The authenticated user is not allowed to access the '
                'specified API endpoint.';
      case 412:
        return response.data?['message'] ?? 'Precondition failed.';
      case 423:
        return response.data?['message'] ?? 'Locked resource.';
      case 404:
        return response.data?['message'] ??
            'The requested resource does not exist.';
      case 500:
        return 'Internal server error.';
      default:
        return 'Oops something went wrong!';
    }
  }

  @override
  String toString() => errorMessage;
}
