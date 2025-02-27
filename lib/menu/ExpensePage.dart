import 'package:expense_tracker/services/expenseApi.dart';
import 'package:expense_tracker/services/loginapi.dart';
import 'package:expense_tracker/user/bottomBar.dart';
import 'package:flutter/material.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  String? selectedCategory;

  // List of predefined categories for expenses
  final List<String> categories = [
    'Food',
    'Transport',
    'Utilities',
    'Entertainment',
    'Shopping',
    'Health',
    'Insurance',
    'Investment',
    'Electronics',
    'Electricity',
    'Rent',
    'Others'
  ];

  List<Map<String, dynamic>> expenses = [];

  void addMore() {
    setState(() {
      // Add the current inputs to the expenses list
      expenses.add({
        "Category": selectedCategory ?? '',
        "Price": priceController.text,
        "Quantity": quantityController.text,
      });

      // Clear the controllers and reset the dropdown
      priceController.clear();
      quantityController.clear();
      selectedCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked:(didPop) {
        if(didPop) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
            (route) => false,
          );
        }
      
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Expenses"),
          centerTitle: true,
          actions: [
            ElevatedButton(
              onPressed: addMore,
              child: const Text("Add "),
            ),
          ],
        ),
        // drawer: Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: [
        //       DrawerHeader(
        //         decoration: BoxDecoration(
        //           color: Colors.green,
        //         ),
        //         child: Text(
        //           "Menu",
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 24,
        //           ),
        //         ),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.feedback),
        //         title: Text("Complaint"),
        //         onTap: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => FeedbackComplaintForm()),
        //           );
        //         },
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.logout),
        //         title: Text("Logout"),
        //         onTap: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => LoginPage()),
        //           );
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (expenses.isEmpty)
                SizedBox(
                  height: 150,
                ),
              if (expenses.isEmpty) const Text("No expenses selected yet"),
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
                              value: expenses[index]["Category"] == null ||
                                      expenses[index]["Category"].isEmpty
                                  ? null
                                  : expenses[index]["Category"],
                              decoration: const InputDecoration(
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
                                  expenses[index]["Category"] = value;
                                });
                              },
                            ),
                            const SizedBox(height: 8.0),
                            // Price input
                            TextField(
                              decoration: const InputDecoration(
                                labelText: "Price",
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(
                                text: expenses[index]["Price"]?.toString(),
                              ),
                              onChanged: (value) {
                                expenses[index]["Price"] =
                                    double.tryParse(value) ?? 0.0;
                              },
                            ),
                            const SizedBox(height: 8.0),
                            // Quantity input
                            TextField(
                              decoration: const InputDecoration(
                                labelText: "Quantity",
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(
                                text: expenses[index]["Quantity"]?.toString(),
                              ),
                              onChanged: (value) {
                                expenses[index]["Quantity"] =
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
                  Expanded(
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: () async {
                        await expenseApi({
                          'USER': loginId,
                          'items': expenses,
                        }, context);
                        expenses.clear();
                        setState(() {});
                      },
                      child: const Text("Submit"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
