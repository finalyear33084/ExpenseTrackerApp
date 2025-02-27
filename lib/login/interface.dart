import 'package:expense_tracker/login/login.dart';
import 'package:expense_tracker/login/registerform.dart';
import 'package:flutter/material.dart';

class ImageInContainer extends StatelessWidget {
  const ImageInContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Added SingleChildScrollView
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50), // Added padding at the top
              // Container with Image
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                  border: Border.all(
                      color: Colors.green, width: 4), // Border styling
                  image: const DecorationImage(
                    image: AssetImage('assets/exp.jpg'), // Local asset
                    // image: NetworkImage('https://example.com/image.jpg'), // For network image
                    fit: BoxFit
                        .cover, // Adjust how the image fits inside the container
                  ),
                ),
              ),
              const SizedBox(height: 20), // Space between the image and text
              // Text Below the Image
              Text(
                "Welcome to MyApp",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
              const SizedBox(height: 30), // Space between text and buttons
              // Login Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                  // Handle Login Action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Background color
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10), // Space between buttons
              // Register Button
              OutlinedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterForm()));
                  // Handle Register Action
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.green, width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 20), // Bottom padding for better spacing
            ],
          ),
        ),
      ),
    );
  }
}
