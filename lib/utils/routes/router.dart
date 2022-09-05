import 'package:flutter/material.dart';
import 'package:places/ui/screen/add_sight/add_sight_screen.dart';
import 'package:places/ui/screen/add_sight/category_list_screen.dart';
import 'package:places/ui/screen/filter/filter_screen.dart';
import 'package:places/ui/screen/list/sight_list_screen.dart';
import 'package:places/ui/screen/map/map_screen.dart';
import 'package:places/ui/screen/nav_screen.dart';
import 'package:places/ui/screen/onboarding/onboarding_screen.dart';
import 'package:places/ui/screen/settings/settings_screen.dart';
import 'package:places/ui/screen/sight_details/sight_details_screen.dart';
import 'package:places/ui/screen/sight_search/sight_search_screen.dart';
import 'package:places/ui/screen/splash/splash_screen.dart';
import 'package:places/ui/screen/unknown/unknown_screen.dart';
import 'package:places/utils/routes/routes.dart';

class RouterFactory {
  // ignore: long-method
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.toMain:
        return MaterialPageRoute<MainScreen>(
          builder: (context) => const MainScreen(),
        );
      case Routes.toSplash:
        return MaterialPageRoute<SplashScreen>(
          builder: (context) => const SplashScreen(),
        );
      case Routes.toOnBoarding:
        return MaterialPageRoute<OnBoardingScreen>(
          builder: (context) => const OnBoardingScreen(),
        );
      case Routes.toMap:
        return MaterialPageRoute<MapScreen>(
          builder: (context) => const MapScreen(),
        );
      case Routes.toSettings:
        return MaterialPageRoute<SettingsScreen>(
          builder: (context) => const SettingsScreen(),
        );
      case Routes.toAddSight:
        return MaterialPageRoute<AddSightScreen>(
          builder: (context) => const AddSightScreen(),
        );
      case Routes.toCategoriesList:
        return MaterialPageRoute<CategoryListScreen>(
          builder: (context) => const CategoryListScreen(),
        );
      case Routes.toFilters:
        return MaterialPageRoute<FilterScreen>(
          builder: (context) => const FilterScreen(),
        );
      case Routes.toDetails:
        final id = settings.arguments as int;
        return MaterialPageRoute<SightDetailsScreen>(
          builder: (context) => SightDetailsScreen(id: id),
        );
      default:
        return MaterialPageRoute<MapScreen>(
          builder: (context) => const UnknownScreen(),
        );
    }
  }

  static Route<dynamic> generateRouteListMenu(RouteSettings settings) {
    switch (settings.name) {
      case Routes.toListOfInterestingSights:
        return MaterialPageRoute<SightListScreen>(
          builder: (context) => const SightListScreen(),
        );
      case Routes.toSearch:
        return MaterialPageRoute<SightSearchScreen>(
          builder: (context) => const SightSearchScreen(),
        );
      default:
        return MaterialPageRoute<UnknownScreen>(
          builder: (context) => const UnknownScreen(),
        );
    }
  }
}
