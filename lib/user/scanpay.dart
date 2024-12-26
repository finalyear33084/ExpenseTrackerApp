import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanAndPayScreen extends StatefulWidget {
  @override
  _ScanAndPayScreenState createState() => _ScanAndPayScreenState();
}

class _ScanAndPayScreenState extends State<ScanAndPayScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _scannedData = '';
  bool _isScanning = false;

  void _startQRCodeScan() async {
    setState(() {
      _isScanning = true;
    });

    // Simulate a delay for scanning or integrate a QR code scanner here.
    await Future.delayed(Duration(seconds: 2));

    // Mock scanned data. Replace with actual QR code scan result.
    setState(() {
      _scannedData = '1234567890'; // Example scanned ID
      _isScanning = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('QR Code Scanned: $_scannedData')),
    );
  }

  void _confirmPayment() {
    final amount = _amountController.text.trim();
    if (amount.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment of \$${amount} confirmed!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid amount.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan & Pay'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // QR Code Scan Button
            ElevatedButton.icon(
              onPressed: _startQRCodeScan,
              icon: Icon(Icons.qr_code_scanner),
              label: Text('Scan QR Code'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            SizedBox(height: 20),

            // Scanned Data Display
            if (_scannedData.isNotEmpty)
              Column(
                children: [
                  Text(
                    'Scanned ID:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _scannedData,
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  SizedBox(height: 20),
                ],
              ),

            // Payment Amount Input
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),

            // Confirm Payment Button
            ElevatedButton(
              onPressed: _confirmPayment,
              child: Text('Confirm Payment'),
              
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}

