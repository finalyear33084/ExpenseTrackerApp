import 'package:dio/dio.dart';

final Dio _dio = Dio();

Future<Map<String, dynamic>> changePassword({
  required String oldPassword,
  required String newPassword,
  required String confirmPassword,
}) async {
  try {
    final response = await _dio.post(
      "/change-password", // Replace with your endpoint
      data: {
        "old_password": oldPassword,
        "new_password": newPassword,
        "confirm_password": confirmPassword,
      },
    );

    if (response.statusCode == 200) {
      return {
        "success": true,
        "message": "Password changed successfully!",
      };
    } else {
      return {
        "success": false,
        "message":
            "Failed to change password. Status code: ${response.statusCode}",
      };
    }
  } on DioError catch (e) {
    String errorMessage = "An error occurred";

    if (e.response != null) {
      errorMessage = e.response?.data['message'] ?? errorMessage;
    } else if (e.type == DioErrorType.receiveTimeout) {
      errorMessage = "Server took too long to respond.";
    }

    return {
      "success": false,
      "message": errorMessage,
    };
  } catch (e) {
    return {
      "success": false,
      "message": "Unexpected error: $e",
    };
  }
}
