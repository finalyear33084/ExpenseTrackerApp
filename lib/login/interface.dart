import 'package:expense_tracker/login/login.dart';
import 'package:expense_tracker/login/registerform.dart';
import 'package:flutter/material.dart';

class ImageInContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Added SingleChildScrollView
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50), // Added padding at the top
              // Container with Image
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                  border: Border.all(
                      color: Colors.green, width: 4), // Border styling
                  image: DecorationImage(
                    image: AssetImage('assets/exp.jpg'), // Local asset
                    // image: NetworkImage('https://example.com/image.jpg'), // For network image
                    fit: BoxFit
                        .cover, // Adjust how the image fits inside the container
                  ),
                ),
              ),
              SizedBox(height: 20), // Space between the image and text
              // Text Below the Image
              Text(
                "Welcome to MyApp",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
              SizedBox(height: 30), // Space between text and buttons
              // Login Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                  // Handle Login Action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Background color
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10), // Space between buttons
              // Register Button
              OutlinedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterForm()));
                  // Handle Register Action
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.green, width: 2),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              SizedBox(height: 20), // Bottom padding for better spacing
            ],
          ),
        ),
      ),
    );
  }
}
