import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/data/interactors/local/database.dart';
import 'package:places/data/interactors/local/places_interactor_local_impl.dart';
import 'package:places/data/interactors/remote/place_interactor_remote_impl.dart';
import 'package:places/data/interactors/search_interactor.dart';
import 'package:places/data/interactors/settings_interactor.dart';
import 'package:places/data/repository/data/place_repository_remote.dart';
import 'package:places/data/repository/local/shared_preferences/local_sp_impl.dart';
import 'package:places/settings/app_settings.dart';
import 'package:places/settings/dio_settings.dart';
import 'package:places/ui/screen/add_place/add_place_settings.dart';
import 'package:places/ui/screen/favourite/favourite_settings.dart';
import 'package:places/ui/screen/filter/filter_settings.dart';
import 'package:places/ui/screen/list/sight_list_settings.dart';
import 'package:places/ui/screen/onboarding/onboarding_settings.dart';
import 'package:places/ui/screen/sight_details/sight_details_settings.dart';
import 'package:places/ui/screen/sight_search/search_settings.dart';
import 'package:places/ui/screen/splash/splash_settings.dart';
import 'package:places/utils/routes/router.dart';
import 'package:places/utils/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = Database();
  final dioSettings = DioSettings();
  final remoteRepository = PlaceRepositoryRemote(dioSettings);
  final interactorRemote = PlaceInteractorImpl(remoteRepository);
  final searchInteractor = SearchInteractor(remoteRepository, db);
  final interactorLocal = PlacesInteractorLocalImpl(db);
  final prefs = await SharedPreferences.getInstance();
  final localSPImpl = LocalSPImpl(prefs);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppSettings>(
          create: (_) => AppSettings(SettingsInteractor(), localSPImpl),
        ),
        ChangeNotifierProvider<SightListSettings>(
          create: (_) => SightListSettings(interactorRemote, interactorLocal),
        ),
        ChangeNotifierProvider<FilterSettings>(
          create: (_) => FilterSettings(interactorRemote, localSPImpl),
        ),
        ChangeNotifierProvider<SearchSettings>(
          create: (_) => SearchSettings(searchInteractor, localSPImpl),
        ),
        ChangeNotifierProvider<FavouriteSettings>(
          create: (_) => FavouriteSettings(interactorLocal),
        ),
        ChangeNotifierProvider<AddPlaceSettings>(
          create: (_) => AddPlaceSettings(interactorRemote),
        ),
        ChangeNotifierProvider<SightDetailsSettings>(
          create: (_) => SightDetailsSettings(
            interactorRemote,
            interactorLocal,
          ),
        ),
        ChangeNotifierProvider<OnBoardingSettings>(
          create: (_) => OnBoardingSettings(),
        ),
        ChangeNotifierProvider<SplashSettings>(
          create: (_) => SplashSettings(localSPImpl),
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
        final systemUiOverlayStyle = model.systemUiOverlayStyle();

        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

        return MaterialApp(
          theme: model.theme(),
          onGenerateRoute: RouterFactory.generateRoute,
          initialRoute: Routes.toSplash,
        );
      },
    );
  }
}
