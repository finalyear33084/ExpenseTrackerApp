import 'package:expense_tracker/login/login.dart';
import 'package:expense_tracker/user/feedback.dart';
import 'package:flutter/material.dart';

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  // List of predefined categories for expenses
  final List<String> categories = [
    'Food', 'Transport', 'Utilities', 'Entertainment', 'Shopping', 'Others'
  ];

  List<Map<String, dynamic>> expenses = [
    {"category": "", "price": 0.0, "quantity": 0}
  ];

  void addMore() {
    setState(() {
      expenses.add({"category": "", "price": 0.0, "quantity": 0});
    });
  }

  void submitExpenses() {
    print("Submitted Expenses: $expenses");
    // You can perform further processing like sending data to a server
    // or saving it locally.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expenses"),
        centerTitle: true,
      ),
      drawer: Drawer( // Adding the Drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                "Menu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text("Feedback"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context)=>FeedbackComplaintForm()));
                // Handle Feedback action
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Feedback tapped!")),
                );
              },
            ),
            
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () { 
                Navigator.push(context, MaterialPageRoute(builder:(context)=> LoginPage()));
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Logout tapped!")),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // Dropdown for category selection
                          DropdownButtonFormField<String>(
                            value: expenses[index]["category"].isEmpty
                                ? null
                                : expenses[index]["category"],
                            decoration: InputDecoration(
                              labelText: "Category",
                              border: OutlineInputBorder(),
                            ),
                            items: categories.map((String category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                expenses[index]["category"] = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 8.0),
                          // Price input
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Price",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              expenses[index]["price"] =
                                  double.tryParse(value) ?? 0.0;
                            },
                          ),
                          const SizedBox(height: 8.0),
                          // Quantity input
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Quantity",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              expenses[index]["quantity"] =
                                  int.tryParse(value) ?? 0;
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: addMore,
                  child: Text("Add More"),
                ),
                ElevatedButton(
                  onPressed: submitExpenses,
                  child: Text("Submit"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
