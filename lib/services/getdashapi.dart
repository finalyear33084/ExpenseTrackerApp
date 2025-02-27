import 'package:dio/dio.dart';
import 'package:expense_tracker/services/loginapi.dart';

final Dio _dio = Dio();
List<Map<String, dynamic>> transactionHistory = [];

Future<List<Map<String, dynamic>>> getDashboardData() async {
  try {
    final response = await _dio.get(
        "$baseurl/ViewTransactionOfUser/$loginId"); // Replace with your endpoint
    print(response.data);
    if (response.statusCode == 200) {
      // Parse the response data
      transactionHistory =
          List<Map<String, dynamic>>.from(response.data).reversed.toList();
      ;
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
