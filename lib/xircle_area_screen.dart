import 'package:flutter/material.dart';

class CircleAreaScreen extends StatefulWidget {
  @override
  _CircleAreaScreenState createState() => _CircleAreaScreenState();
}

class _CircleAreaScreenState extends State<CircleAreaScreen> {
  final TextEditingController _radiusController = TextEditingController();
  String? _result;

  void calculateArea() {
    double radius = double.tryParse(_radiusController.text) ?? 0;
    double area = 3.14159 * radius * radius;
    setState(() {
      _result = 'Area of Circle: ${area.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Area of Circle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _radiusController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Radius'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateArea,
              child: Text('Calculate Area'),
            ),
            if (_result != null) Text(_result!),
          ],
        ),
      ),
    );
  }
}
