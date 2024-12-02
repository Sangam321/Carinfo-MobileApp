import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('RichText Example'),
        ),
        body: Center(
          child: RichText(
            text: TextSpan(
              text: 'Hello, ',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Sangam',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                TextSpan(
                  text: 'Basnet',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
