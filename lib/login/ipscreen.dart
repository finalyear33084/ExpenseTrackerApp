import 'package:expense_tracker/login/interface.dart';
import 'package:expense_tracker/services/loginapi.dart';
import 'package:flutter/material.dart';




class BaseUrlScreen extends StatefulWidget {
  const BaseUrlScreen({super.key});

  @override
  _BaseUrlScreenState createState() => _BaseUrlScreenState();
}

class _BaseUrlScreenState extends State<BaseUrlScreen> {
  final TextEditingController _controller = TextEditingController(text: 'http://192.168.1.5:5000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Base URL'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Base URL',
                hintText: 'http://192.168.1.10:5000',
                border: OutlineInputBorder(),
              ),
             
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               
                  baseurl = _controller.text;
              
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ImageInContainer()));
                 

                // Navigate to the next screen or do something with the base URL
                print('Base URL: $baseurl');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Base URL set to: $baseurl')),
                );
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
