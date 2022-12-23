import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/settings/app_settings.dart';
import 'package:places/utils/routes/router.dart';
import 'package:places/utils/routes/routes.dart';
import 'package:provider/provider.dart';

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
