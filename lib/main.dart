import 'package:expense_tracker/login/interface.dart';
import 'package:expense_tracker/login/ipscreen.dart';
import 'package:expense_tracker/reminder.dart';
import 'package:expense_tracker/services/getdashapi.dart';
import 'package:expense_tracker/services/getprofileapi.dart';
import 'package:expense_tracker/services/loginapi.dart';
import 'package:expense_tracker/user/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init(); // Initialize and schedule notification
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(), // Check if user is logged in
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading screen
          } else if (snapshot.hasData && snapshot.data == true) {
            return const BottomNavBarScreen(); // If logged in, navigate to BottomNavBarScreen
          } else {
            return const BaseUrlScreen(); // Otherwise, show BaseUrlScreen (login/signup)
          }
        },
      ),
    );
  }

  /// ✅ Function to check if user is logged in
  static Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   loginId = prefs.getString('login_id')??'';
     baseurl = prefs.getString('base_url')??'';

    if (loginId != null && loginId!.isNotEmpty) {
      await getProfile(); // Fetch user profile
      await getDashboardData(); // Fetch dashboard data
      return true; // User is logged in
    } else {
      return false; // User is NOT logged in
    }
  }
}
