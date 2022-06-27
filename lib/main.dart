import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/screeen/sight_list_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SightListScreen(),
    );
  }
}
