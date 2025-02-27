import 'package:dio/dio.dart';
import 'package:expense_tracker/services/loginapi.dart';

Map<String, dynamic> profiledata={};

Future<Map<String, dynamic>> getProfile( ) async {
 
  final Dio dio = Dio();

  try {
    final response = await dio.get(
      '$baseurl/ViewProfileApi/$loginId', // Replace with your API endpoint
     
    );
print(response.data);
    if (response.statusCode == 200) {
      // If the server returns a successful response, return the profile data
      profiledata=response.data as Map<String, dynamic>;
      return response.data as Map<String, dynamic>;
    } else {
      // Handle unexpected status codes
      throw Exception('Failed to load profile: ${response.statusMessage}');
    }
  } on DioException catch (e) {
    // Handle Dio-specific errors
    if (e.response != null) {
      throw Exception('Failed to load profile: ${e.response?.data}');
    } else {
      throw Exception('Failed to load profile: ${e.message}');
    }
  } catch (e) {
    // Handle other errors
    throw Exception('Failed to load profile: $e');
  }
}
