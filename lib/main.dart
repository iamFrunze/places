import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/settings/app_settings.dart';
import 'package:places/data/repository/mock_data/mock_sights.dart';
import 'package:places/data/repository/mock_data/mock_visited_sights.dart';
import 'package:places/data/repository/mock_data/mock_want_visit_sights.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/themes/dark_theme.dart';
import 'package:places/res/themes/light_theme.dart';
import 'package:places/settings/dio_settings.dart';
import 'package:places/ui/screen/add_sight/add_sight_settings.dart';
import 'package:places/ui/screen/favourite/favourite_settings.dart';
import 'package:places/ui/screen/filter/filter_settings.dart';
import 'package:places/ui/screen/onboarding/onboarding_settings.dart';
import 'package:places/ui/screen/sight_details/sight_details_settings.dart';
import 'package:places/ui/screen/sight_search/search_settings.dart';
import 'package:places/ui/screen/splash/splash_settings.dart';
import 'package:places/utils/routes/router.dart';
import 'package:places/utils/routes/routes.dart';
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
        ChangeNotifierProvider<SightDetailsSettings>(
          create: (_) => SightDetailsSettings(
            repository: mockSights,
            wantVisitRepository: MockWantVisitSights(),
          ),
        ),
        ChangeNotifierProvider<OnBoardingSettings>(
          create: (_) => OnBoardingSettings(),
        ),
        ChangeNotifierProvider<SplashSettings>(
          create: (_) => SplashSettings(),
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
  void initState() {
    super.initState();
    testGet();
  }

  final dioSettings = DioSettings();

  Future<void> testGet() async {
    final a = await dioSettings.dio.get<Response>('');
    debugPrint('$a');
  }

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

        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

        return MaterialApp(
          theme: !isDarkMode
              ? LightThemeData().buildTheme()
              : DarkThemeData().buildTheme(),
          onGenerateRoute: RouterFactory.generateRoute,
          initialRoute: Routes.toSplash,
        );
      },
    );
  }
}
