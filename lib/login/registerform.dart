import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade400, Colors.green.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header Section
                  Text(
                    "Create an Account",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Sign up to get started",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  SizedBox(height: 30),

                  // Form in a Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Name Field
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Enter Your Name",
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your name";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            // Email Field
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Enter Your Email",
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email";
                                }
                                final emailRegex = RegExp(
                                    r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                                if (!emailRegex.hasMatch(value)) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            // Password Field
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Enter Your Password",
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your password";
                                }
                                if (value.length < 6) {
                                  return "Password must be at least 6 characters long";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            // Confirm Password Field
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Confirm Password",
                                prefixIcon: Icon(Icons.lock_outline),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please confirm your password";
                                }
                                if (value != passwordController.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            // Register Button
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Registration Successful!"),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Colors.green.shade700,
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                              ),
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            // Google Button
                            OutlinedButton.icon(
                              onPressed: () {
                                // Handle Google Login
                              },
                              icon: Image.asset(
                                'assets/logo.jpg', // Add your Google icon here
                                height: 20,
                                width: 20,
                              ),
                              label: Text(
                                "Continue with Google",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.black26),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Footer Section
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Login Screen
                    },
                    child: Text(
                      "Already have an account? Log In",
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RegisterForm(),
  ));
}
