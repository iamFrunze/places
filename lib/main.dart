import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyFirstWidget(),
    );
  }
}

class MyFirstWidget extends StatefulWidget {

  const MyFirstWidget({Key? key}) : super(key: key);

  @override
  State<MyFirstWidget> createState() => _MyFirstWidgetState();
}

class _MyFirstWidgetState extends State<MyFirstWidget> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    counter++;
    if (kDebugMode) {
      print('Build create ::: $counter');
    }
    return Container(
      child: const Center(
        child: Text('Hello'),
      ),
    );
  }
}
