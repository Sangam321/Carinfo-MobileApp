import 'package:flutter/material.dart';

class ArithmeticScreen extends StatefulWidget {
  @override
  _ArithmeticScreenState createState() => _ArithmeticScreenState();
}

class _ArithmeticScreenState extends State<ArithmeticScreen> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  String? _result;

  void calculateSum() {
    double num1 = double.tryParse(_num1Controller.text) ?? 0;
    double num2 = double.tryParse(_num2Controller.text) ?? 0;
    setState(() {
      _result = 'Sum: ${(num1 + num2).toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arithmetic'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _num1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter first number'),
            ),
            TextField(
              controller: _num2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter second number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateSum,
              child: Text('Calculate Sum'),
            ),
            if (_result != null) Text(_result!),
          ],
        ),
      ),
    );
  }
}
