import 'package:dio/dio.dart';
import 'package:expense_tracker/services/loginapi.dart';
import 'package:flutter/material.dart';


final Dio _dio = Dio();


Future<void> registerfun(context,name,email,password,confirmPassword,address,phoneNo,totalIncome) async {
   
      try {
        final response = await _dio.post(
           "$baseurl/UserReg", // Replace with your API endpoint
          data: {
            "Name": name,
            "Email": email,
            "Password": password,
            "Address":address,
            "PhoneNumber":phoneNo,
            "Totalincome":totalIncome,
            "Username":email,
          },
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful!')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration failed: ${response.data['message']}')),
          );
        }
      } on DioException catch (e) {
        String errorMessage = "An error occurred";

        if (e.response != null) {
          errorMessage = e.response?.data['message'] ?? errorMessage;
        } else if (e.type == DioExceptionType.receiveTimeout) {
          errorMessage = "Server took too long to respond.";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected error: $e')),
        );
      }
    }
  