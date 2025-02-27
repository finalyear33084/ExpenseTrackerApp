// import 'package:dio/dio.dart';

// final Dio _dio = Dio();

// Future<Map<String, dynamic>> chatbotData({
//   required String endpoint, // API endpoint
//   required Map<String, dynamic> data, // Data to submit
// }) async {
//   try {
//     final response = await _dio.post(endpoint, data: data);

//     if (response.statusCode == 201 || response.statusCode == 200) {
//       return {
//         "success": true,
//         "message": "Data submitted successfully!",
//         "data": response.data, // Optionally return server response data
//       };
//     } else {
//       return {
//         "success": false,
//         "message": "Failed to submit data. Status code: ${response.statusCode}",
//       };
//     }
//   } on DioException catch (e) {
//     String errorMessage = "An error occurred";

//     if (e.response != null) {
//       errorMessage = e.response?.data['message'] ?? errorMessage;
//     }  else if (e.type == DioExceptionType.receiveTimeout) {
//       errorMessage = "Server took too long to respond.";
//     }

//     return {
//       "success": false,
//       "message": errorMessage,
//     };
//   } catch (e) {
//     return {
//       "success": false,
//       "message": "Unexpected error: $e",
//     };
//   }
// }
