import 'package:dio/dio.dart';
import 'package:expense_tracker/services/loginapi.dart';
import 'package:flutter/material.dart';

final Dio _dio = Dio();

Future<void> paymentData({
  context,
  required Map<String, dynamic> data, // Data to submit
}) async {
  try {
    final response = await _dio.post('$baseurl/ViewTransactionApi', data: data);

    if (response.statusCode == 201 || response.statusCode == 200) {
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('payment success')));
    } else {
      print(response.data);
    }
  } on DioException catch (e) {
    String errorMessage = "An error occurred";
print(e);
    if (e.response != null) {
      errorMessage = e.response?.data['message'] ?? errorMessage;
    }  else if (e.type == DioExceptionType.receiveTimeout) {
      errorMessage = "Server took too long to respond.";
    }

  }
}
