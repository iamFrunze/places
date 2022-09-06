import 'package:flutter/material.dart';
import 'package:places/utils/routes/router.dart';
import 'package:places/utils/routes/routes.dart';

class ListMenu extends StatelessWidget {
  const ListMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Navigator(
      key: ValueKey('ListMenu'),
      initialRoute: Routes.toListOfInterestingSights,
      onGenerateRoute: RouterFactory.generateRouteListMenu,
    );
  }
}
