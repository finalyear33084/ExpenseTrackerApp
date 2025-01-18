import 'package:dio/dio.dart';
import 'package:expense_tracker/services/loginapi.dart';
import 'package:flutter/material.dart';

final Dio _dio = Dio();

Future<void> expenseApi(  data,context) async {
  try {
    final response = await _dio.post('$baseurl/ViewIncomeApi',  data: data);

    if (response.statusCode == 201 || response.statusCode== 200) {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('success')));
    } else {
      
    }
  } on DioError catch (e) {
    String errorMessage = "An error occurred";
print(e);
   

   
  } catch (e) {
    print(e);
  }
}
