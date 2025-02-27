import 'package:dio/dio.dart';
import 'package:expense_tracker/services/getdashapi.dart';

import 'package:expense_tracker/services/getprofileapi.dart';
import 'package:expense_tracker/user/bottomBar.dart';
import 'package:flutter/material.dart';

final Dio _dio = Dio();
String baseurl = '';
String? loginId;
Future<Map<String, dynamic>> loginfun(
    String username, String password, context) async {
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
      if (response.data['message'] == 'success') {
        loginId = response.data['login_id'].toString();
        await getProfile();
        await getDashboardData();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (ct) => const BottomNavBarScreen()),
          (route) => false,
        );
        return {
          "success": true,
          "data": response.data,
        };
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.data['message'] ?? 'login failed'),
          backgroundColor: Colors.red,
        ),
      );
      return {};
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.data['message'] ?? "login failed"),
          backgroundColor: Colors.red,
        ),
      );
      return {
        "success": false,
        "message": "Login failed. Status code: ${response.statusCode}",
      };
    }
  } on DioException catch (e) {
    String errorMessage = "An error occurred";

    // if (e.response != null) {
    //   errorMessage = e.response?.data['message'] ?? errorMessage;
    // } else if (e.type == DioExceptionType.sendTimeout) {
    //   errorMessage = "Connection timeout. Please try again later.";
    // } else if (e.type == DioExceptionType.receiveTimeout) {
    //   errorMessage = "Server took too long to respond.";
    // }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Somthing wrong'),
        backgroundColor: Colors.red,
      ),
    );
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
