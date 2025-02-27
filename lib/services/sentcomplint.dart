import 'package:dio/dio.dart';
import 'package:expense_tracker/services/loginapi.dart';
import 'package:flutter/material.dart';

final Dio _dio = Dio();

Future<void> submitcomplaint({
  
  required Map<String, dynamic> data, // Data to submit
  context
}) async {
  try {
    final response = await _dio.post('$baseurl/ViewComplaintApi', data: data);

    if (response.statusCode == 201 || response.statusCode == 200) {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('send')));
    } else {
     print('failed');
    }
  } on DioException catch (e) {
    String errorMessage = "An error occurred";

   print(e);
  } catch (e) {
    print(e);


}}









Future<List<Map<String, dynamic>>> viewComplaints() async {
  try {
    final response =
        await _dio.get("$baseurl/ViewComplaintApi",data: {'USER':loginId}); // Replace with your endpoint
print(response.data);
    if (response.statusCode == 200) {
      // Parse the response data
     
      return List<Map<String, dynamic>>.from(response.data);
     
    } else {
      return [];
    }
  } on DioException catch (e) {
    
print(e); 
   

    return [];
  } catch (e) {
    return [];
  }
}

