import 'package:dio/dio.dart';

final Dio _dio = Dio();

Future<Map<String, dynamic>> updateProfile({
  required String name,
  required String email,
  required String phone,
}) async {
  try {
    final response = await _dio.post(
      "/update-profile", // Replace with your endpoint
      data: {
        "name": name,
        "email": email,
        "phone": phone,
      },
    );

    if (response.statusCode == 200) {
      return {
        "success": true,
        "message": "Profile updated successfully!",
        "data": response.data, // Optionally return server response data
      };
    } else {
      return {
        "success": false,
        "message":
            "Failed to update profile. Status code: ${response.statusCode}",
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
