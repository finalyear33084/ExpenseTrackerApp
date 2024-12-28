import 'package:dio/dio.dart';

final Dio _dio = Dio();

Future<Map<String, dynamic>> getDashboardData() async {
  try {
    final response =
        await _dio.get("/dashboard-data"); // Replace with your endpoint

    if (response.statusCode == 200) {
      // Parse the response data
      return {
        "success": true,
        "chartData": response.data['chart_data'], // Adjust key names as per API
        "spendTotal": response.data['spend_total'],
        "spendBalance": response.data['spend_balance'],
        "transactionHistory": response.data['transaction_history'],
      };
    } else {
      return {
        "success": false,
        "message": "Failed to fetch data. Status code: ${response.statusCode}",
      };
    }
  } on DioError catch (e) {
    String errorMessage = "An error occurred";

    if (e.response != null) {
      errorMessage = e.response?.data['message'] ?? errorMessage;
    } else if (e.type == DioExceptionType.connectionTimeout) {
      errorMessage = "Connection timeout. Please try again later.";
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
