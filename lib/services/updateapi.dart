import 'package:dio/dio.dart';
import 'package:expense_tracker/services/getprofileapi.dart';
import 'package:expense_tracker/services/loginapi.dart';
import 'package:flutter/material.dart';

final Dio _dio = Dio();

Future<void> updateProfile({
 data,
 context
}) async {
  try {
    final response = await _dio.put(
      "$baseurl/UserUpdation/$loginId", // Replace with your endpoint
      data:data
    );

    if (response.statusCode == 200) {
   await   getProfile();
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('profile updated')));
    } else {
      print('failed');
    }
  } on DioException catch (e) {
    String errorMessage = "An error occurred";

   

   print(e);
  } catch (e) {
   print(e);
  }
}
