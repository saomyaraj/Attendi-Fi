import 'package:flutter/material.dart';
import 'firstscreen_selectuser.dart';

void main() {
  runApp(MaterialApp(
    home: firstscreen(),
  ));
}

class MyAppMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Application Page"),
      ),
      body: Center(
        child: Text("Welcome to the Main Application!"),
      ),
    );
  }
}
