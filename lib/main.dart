import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/themes/dark_theme.dart';
import 'package:places/res/themes/light_theme.dart';
import 'package:places/ui/screen/nav_screen.dart';
import 'package:places/utils/app_settings.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AppSettingsModel(),
    child: const App(),
  ));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsModel>(builder: (context, model, child) {
      final isDarkMode = model.isDarkMode;
      final systemUiOverlayStyle = !isDarkMode
          ? SystemUiOverlayStyle.light.copyWith(
              systemNavigationBarColor: AppColors.lmPrimaryColor,
              statusBarColor: Colors.transparent,
            )
          : SystemUiOverlayStyle.dark.copyWith(
              systemNavigationBarColor: AppColors.dmMainColorKit,
              statusBarColor: Colors.transparent,
            );

      return MaterialApp(
        theme: !isDarkMode ? LightThemeData().buildTheme() : DarkThemeData().buildTheme(),
        // home: SightDetailsScreen(sight: mocks[1],),
        home: AnnotatedRegion<SystemUiOverlayStyle>(
          value: systemUiOverlayStyle,
          child: const MainScreen(),
        ),
      );
    });
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NavScreen();
}
