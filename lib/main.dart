import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/interactors/place_interactor_impl.dart';
import 'package:places/data/interactors/search_interactor.dart';
import 'package:places/data/interactors/settings_interactor.dart';
import 'package:places/data/repository/data/place_repository_remote.dart';
import 'package:places/settings/app_settings.dart';
import 'package:places/settings/dio_settings.dart';
import 'package:places/ui/screen/filter/filter_settings.dart';
import 'package:places/ui/screen/onboarding/onboarding_settings.dart';
import 'package:places/ui/screen/sight_details/sight_details_settings.dart';
import 'package:places/ui/screen/sight_search/redux/middleware.dart';
import 'package:places/ui/screen/sight_search/redux/reducers.dart';
import 'package:places/ui/screen/sight_search/redux/search_state.dart';
import 'package:places/ui/screen/sight_search/search_settings.dart';
import 'package:places/ui/screen/splash/splash_settings.dart';
import 'package:places/utils/routes/router.dart';
import 'package:places/utils/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

void main() async {
  final dioSettings = DioSettings();
  final remoteRepository = PlaceRepositoryRemote(dioSettings);
  final interactor = PlaceInteractorImpl(remoteRepository);
  final searchInteractor = SearchInteractor(remoteRepository);
  final store = Store<SearchState>(
    reducer,
    middleware: [SearchMiddleware(searchInteractor)],
    initialState: LoadingState(),
  );
  runApp(
    MultiProvider(
      providers: [
        Provider<Store<SearchState>>(create: (_) => store),
        Provider<PlaceInteractorImpl>(create: (_) => interactor),
        ChangeNotifierProvider<AppSettings>(
          create: (_) => AppSettings(SettingsInteractor()),
        ),
        ChangeNotifierProvider<FilterSettings>(
          create: (_) => FilterSettings(interactor),
        ),
        ChangeNotifierProvider<SearchSettings>(
          create: (_) => SearchSettings(searchInteractor),
        ),
        ChangeNotifierProvider<SightDetailsSettings>(
          create: (_) => SightDetailsSettings(interactor),
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
  Widget build(BuildContext context) {
    return Consumer<AppSettings>(
      builder: (context, model, child) {
        final systemUiOverlayStyle = model.systemUiOverlayStyle();

        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

        return StoreProvider(
          store: context.read<Store<SearchState>>(),
          child: MaterialApp(
            theme: model.theme(),
            onGenerateRoute: RouterFactory.generateRoute,
            initialRoute: Routes.toSplash,
          ),
        );
      },
    );
  }
}
