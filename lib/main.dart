import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
    if (kDebugMode) {
      print('Context ::: ${fetchContextType(context)}');
    }
    return const MaterialApp(
      title: 'My first widget',
      home: MyFirstStatefullWidget(),
    );
  }

  Type fetchContextType(BuildContext context) {
    return context.runtimeType;
  }
}

class MyFirstStatelessWidget extends StatelessWidget {
  MyFirstStatelessWidget({Key? key}) : super(key: key);
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('Context ::: ${fetchContextType(context)}');
      print('Build create ::: $counter');
    }

    counter++;

    return Container(
      child: const Center(
        child: Text('Hello'),
      ),
    );
  }

  Type fetchContextType(BuildContext context) {
    return context.runtimeType;
  }
}

class MyFirstStatefullWidget extends StatefulWidget {
  const MyFirstStatefullWidget({Key? key}) : super(key: key);

  @override
  State<MyFirstStatefullWidget> createState() => _MyFirstStatefullWidgetState();
}

class _MyFirstStatefullWidgetState extends State<MyFirstStatefullWidget> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('Context ::: ${fetchContextType(context)}');
      print('Build create ::: $counter');
    }
    counter++;

    return Container(
      child: const Center(
        child: Text('Hello'),
      ),
    );
  }

  Type fetchContextType(BuildContext context) {
    return context.runtimeType;
  }
}
