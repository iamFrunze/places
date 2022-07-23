import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/themes/dark_theme.dart';
import 'package:places/res/themes/light_theme.dart';
import 'package:places/ui/screen/visiting_screen.dart';

void main() {
  final isLight = true;
  if (isLight) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.lmPrimaryColor,
      statusBarColor: AppColors.lmPrimaryColor,
    ));
  } else {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.dmMainColorKit,
      statusBarColor: AppColors.dmMainColorKit,
    ));
  }
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeData theme = LightThemeData().buildTheme();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => VisitingScreen();
}
