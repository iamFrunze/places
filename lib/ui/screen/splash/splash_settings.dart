import 'package:flutter/material.dart';
import 'package:places/data/repository/local/shared_preferences/local_sp_impl.dart';
import 'package:places/utils/routes/routes.dart';

enum SplashGoTo { goToOnBoarding, goToMain }

class SplashSettings extends ChangeNotifier {
  final LocalSPImpl _prefs;
  SplashGoTo? splashRoute;

  SplashSettings(this._prefs);

  Future<void> navigateToNext(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 5), () {})
        .whenComplete(() => route(context));
  }

  void route(BuildContext context) {
    final isFirst = _prefs.fetchFirstLogin();
    if (isFirst) {
      _prefs.saveFirstLogin();
      Future.microtask(
        () => Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.toOnBoarding,
          (route) => false,
        ),
      );
    } else {
      Future.microtask(
        () => Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.toMain,
          (route) => false,
        ),
      );
    }
  }
}
