import 'package:expense_tracker/login/interface.dart';
import 'package:expense_tracker/login/ipscreen.dart';
import 'package:expense_tracker/reminder.dart';
import 'package:flutter/material.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init(); // Initialize and schedule notification
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
    
      home: BaseUrlScreen(),
    
    );
  }
}

 


