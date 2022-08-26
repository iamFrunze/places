import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/app_settings.dart';
import 'package:places/data/repository/mock_data/mock_sights.dart';
import 'package:places/data/repository/mock_data/mock_visited_sights.dart';
import 'package:places/data/repository/mock_data/mock_want_visit_sights.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/themes/dark_theme.dart';
import 'package:places/res/themes/light_theme.dart';
import 'package:places/ui/screen/add_sight/add_sight_settings.dart';
import 'package:places/ui/screen/favourite/favourite_settings.dart';
import 'package:places/ui/screen/filter/filter_settings.dart';
import 'package:places/ui/screen/nav_screen.dart';
import 'package:places/ui/screen/sight_search/search_settings.dart';
import 'package:provider/provider.dart';

void main() async {
  final mockSights = MockSights();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppSettings>(
          create: (_) => AppSettings(),
        ),
        ChangeNotifierProvider<FilterSettings>(
          create: (_) => FilterSettings(repository: mockSights),
        ),
        ChangeNotifierProvider<SearchSettings>(
          create: (_) => SearchSettings(repository: mockSights),
        ),
        ChangeNotifierProvider<FavouriteSettings>(
          create: (_) => FavouriteSettings(
            visitedSightsRepository: MockVisitedSights(),
            wantVisitSightsRepository: MockWantVisitSights(),
          ),
        ),
        ChangeNotifierProvider<AddSightSettings>(
          create: (_) => AddSightSettings(repository: mockSights),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettings>(
      builder: (context, model, child) {
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
          theme: !isDarkMode
              ? LightThemeData().buildTheme()
              : DarkThemeData().buildTheme(),
          home: AnnotatedRegion<SystemUiOverlayStyle>(
            value: systemUiOverlayStyle,
            child: const MainScreen(),
          ),
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NavScreen();
}
