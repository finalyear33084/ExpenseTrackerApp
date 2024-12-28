import 'package:dio/dio.dart';

final Dio _dio = Dio();

Future<Map<String, dynamic>> getNotifications() async {
  try {
    final response = await _dio
        .get("/notifications"); // Replace with your notifications endpoint

    if (response.statusCode == 200) {
      // Parse and return the notifications
      return {
        "success": true,
        "notifications": response
            .data['notifications'], // Adjust key name as per API response
      };
    } else {
      return {
        "success": false,
        "message":
            "Failed to fetch notifications. Status code: ${response.statusCode}",
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
