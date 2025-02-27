import 'package:dio/dio.dart';
import 'package:expense_tracker/services/loginapi.dart';
import 'package:flutter/material.dart';

final Dio _dio = Dio();

Future<void> changePassword({
 data,context
}) async {
  print('paswoes');
  try {
    final response = await _dio.put(
      "$baseurl/UserUpdatepassword/$loginId", // Replace with your endpoint
      data: data
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('password updated')));
      Navigator.pop(context);
    } else {
     print('failed to update');
    }
  } on DioException catch (e) {
    String errorMessage = "An error occurred";

   
   print(e);
  } catch (e) {
   print(e);
  }
}
