import 'package:flutter/material.dart';
import 'package:places/data/category_model.dart';
import 'package:places/data/filter_model.dart';
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
        return MaterialPageRoute<void>(
          builder: (context) => const MainScreen(),
        );
      case Routes.toSplash:
        return MaterialPageRoute<void>(
          builder: (context) => const SplashScreen(),
        );
      case Routes.toOnBoarding:
        return MaterialPageRoute<void>(
          builder: (context) => const OnBoardingScreen(),
        );
      case Routes.toMap:
        return MaterialPageRoute<void>(
          builder: (context) => const MapScreen(),
        );
      case Routes.toSettings:
        return MaterialPageRoute<void>(
          builder: (context) => const SettingsScreen(),
        );
      case Routes.toAddSight:
        return MaterialPageRoute<void>(
          builder: (context) => const AddSightScreen(),
        );
      case Routes.toCategoriesList:
        return MaterialPageRoute<CategoryModel>(
          builder: (context) => const CategoryListScreen(),
        );
      case Routes.toFilters:
        return MaterialPageRoute<FilterModel>(
          builder: (context) => const FilterScreen(),
        );
      case Routes.toDetails:
        final id = settings.arguments as int;
        return MaterialPageRoute<void>(
          builder: (context) => SightDetailsScreen(id: id),
        );
      default:
        return MaterialPageRoute<void>(
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
