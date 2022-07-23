import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/themes/dark_theme.dart';
import 'package:places/res/themes/light_theme.dart';
import 'package:places/ui/screen/list/sight_details_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';


void main() {
  final isLight = true;
  if (isLight) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.lmPrimaryColor,
      statusBarColor: Colors.transparent,
    ));
  } else {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.dmMainColorKit,
      statusBarColor: Colors.transparent,
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
      // home: SightDetailsScreen(sight: mocks[1],),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => VisitingScreen();
}
