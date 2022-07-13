import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_resources.dart';
import 'package:places/ui/widgets/sight_card.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    final cards = mocks.map((sight) => SightCard(sight: sight)).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _AppBarWidget(),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: cards,
          ),
        ),
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, top: 64),
        child: const Text(
          AppStrings.interestingPlaces,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
