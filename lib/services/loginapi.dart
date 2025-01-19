import 'package:dio/dio.dart';
import 'package:expense_tracker/services/getdashapi.dart';

import 'package:expense_tracker/services/getprofileapi.dart';
import 'package:expense_tracker/user/bottomBar.dart';
import 'package:flutter/material.dart';

final Dio _dio = Dio();
String baseurl='http://192.168.247.93:5000';
String? loginId;
Future<Map<String, dynamic>> loginfun(String username, String password,context) async {
  try {
    print('object');
    final response = await _dio.post(
      "$baseurl/LoginPage/", // Replace with your login endpoint
      data: {
        "username": username,
        "password": password,
      },
    );
    print(response.data);

    if (response.statusCode == 200) {
      if (response.data['message']=='success') {
         loginId=response.data['login_id'].toString();
      await   getProfile();
      getDashboardData();
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (ct)=>BottomNavBarScreen()));
      return {
        "success": true,
        "data": response.data,
      };
      }
     return {};
    } else {
      return {
        "success": false,
        "message": "Login failed. Status code: ${response.statusCode}",
      };
    }
  } on DioError catch (e) {
    String errorMessage = "An error occurred";

    if (e.response != null) {
      errorMessage = e.response?.data['message'] ?? errorMessage;
    } else if (e.type == DioExceptionType.sendTimeout) {
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
