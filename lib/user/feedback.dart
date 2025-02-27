import 'package:expense_tracker/services/loginapi.dart';
import 'package:expense_tracker/services/sentcomplint.dart';
import 'package:flutter/material.dart';

class FeedbackComplaintForm extends StatefulWidget {
  List<Map<String, dynamic>> feedbacks;

  FeedbackComplaintForm({super.key, required this.feedbacks});
  @override
  _FeedbackComplaintFormState createState() => _FeedbackComplaintFormState();
}

class _FeedbackComplaintFormState extends State<FeedbackComplaintForm> {
  final _formKey = GlobalKey<FormState>(); // Form key to validate inputs
  // final _feedbackController = TextEditingController();
  final _complaintController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // final feedback = _feedbackController.text;
      final complaint = _complaintController.text;
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomeScreen()),
      // );

      // You can handle the submission logic here
      await submitcomplaint(data: {
        'USER': loginId,
        'Complaint': complaint,
        // 'Reply':,
        'Date': DateTime.now().toString().substring(0, 10),
      }, context: context);

      // Clear the fields
      // _feedbackController.clear();
      _complaintController.clear();
      widget.feedbacks = await viewComplaints();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complaint"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Complaint Field
              const Text(
                "Your Complaint:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _complaintController,
                maxLines: 4,
                decoration: const InputDecoration(
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
              const SizedBox(height: 30),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ListView.builder(
                    reverse: true,
                itemCount: widget.feedbacks.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                          'Complaint: ${widget.feedbacks[index]['Complaint']}'),
                      subtitle:
                          Text('Reply: ${widget.feedbacks[index]['Reply']}'),
                    ),
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
