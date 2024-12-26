import 'package:expense_tracker/user/homescreen.dart';
import 'package:flutter/material.dart';

class FeedbackComplaintForm extends StatefulWidget {
  @override
  _FeedbackComplaintFormState createState() => _FeedbackComplaintFormState();
}

class _FeedbackComplaintFormState extends State<FeedbackComplaintForm> {
  final _formKey = GlobalKey<FormState>(); // Form key to validate inputs
  final _feedbackController = TextEditingController();
  final _complaintController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final feedback = _feedbackController.text;
      final complaint = _complaintController.text;
       Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );

      // You can handle the submission logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Form Submitted Successfully!"),
        ),
      );

      // Clear the fields
      _feedbackController.clear();
      _complaintController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback and Complaint"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Feedback Field
              Text(
                "Your Feedback:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _feedbackController,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Write your feedback here...",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Feedback cannot be empty!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Complaint Field
              Text(
                "Your Complaint:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _complaintController,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Write your complaint here...",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Complaint cannot be empty!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

