import 'package:expense_tracker/services/expenseApi.dart';
import 'package:expense_tracker/services/loginapi.dart';
import 'package:expense_tracker/user/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanAndPayScreen extends StatefulWidget {
  const ScanAndPayScreen({super.key});

  @override
  _ScanAndPayScreenState createState() => _ScanAndPayScreenState();
}

class _ScanAndPayScreenState extends State<ScanAndPayScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  String _scannedData = ''; // Made mutable
  final MobileScannerController scannerController = MobileScannerController();

  String? selectedCategory;
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

  void _confirmPayment() async {
    final amount = _amountController.text.trim();
    if (amount.isNotEmpty) {
      await expenseApi({
        'USER': loginId,
        'items': [
          {
            "Category":selectedCategory??'Qr Payment',
            "Price": _amountController.text,
            "Quantity": 1,
          }
        ],
      }, context);
      _amountController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Scan & Pay'),
          centerTitle: true,
          // backgroundColor: Colors.deepPurple, // AppBar color
          elevation: 5,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // QR Code Scan Button
              ElevatedButton.icon(
                onPressed: () async {
                  final scannedResult = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QRScannerScreen()),
                  );
                  if (scannedResult != null) {
                    setState(() {
                      _scannedData = scannedResult;
                    });
                  }
                },
                icon: Icon(
                  Icons.qr_code_scanner,
                  size: 40,
                  color: Colors.white,
                ),
                label: const Text(
                  'Scan QR Code',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Scanned Data Display
              if (_scannedData.isNotEmpty)
                Column(
                  children: [
                    const Text(
                      'Scanned ID:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _scannedData,
                      style: const TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),

              // Payment Amount Input
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Enter Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
             DropdownButtonFormField<String>(
                              value: selectedCategory ,
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
                                  selectedCategory = value;
                                });
                              },
                            ),
              const SizedBox(height: 20),

              // Confirm Payment Button
              ElevatedButton(
                onPressed: _confirmPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Confirm Payment',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QRScannerScreen extends StatelessWidget {
  QRScannerScreen({super.key});

  final MobileScannerController scannerController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Scanner"),
        backgroundColor: Colors.deepPurple,
      ),
      body: MobileScanner(
        controller: scannerController,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty) {
            final String scannedValue = barcodes.first.rawValue ?? "Unknown";

            // Pop back to the previous screen and send the scanned data

            scannerController.dispose();
            Navigator.pop(context, scannedValue);
          }
        },
      ),
    );
  }
}
