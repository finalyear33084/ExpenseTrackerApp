import 'package:dio/dio.dart';
import 'package:expense_tracker/reminder.dart';
import 'package:expense_tracker/services/getprofileapi.dart';
import 'package:expense_tracker/services/loginapi.dart';
import 'package:flutter/material.dart';

final Dio _dio = Dio();

double balanceee = 0;

Future<void> expenseApi(data, context) async {
  try {
    // sendNotification();
    if (balanceee < 1000) {
      NotificationService.sendLowBalanceNotification();
    }
    final response = await _dio.post('$baseurl/ViewIncomeApi', data: data);

    if (response.statusCode == 201 || response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('success')));
    } else {}
  } on DioException catch (e) {
    String errorMessage = "An error occurred";
    print(e);
  } catch (e) {
    print(e);
  }
}
