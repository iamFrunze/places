import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_card.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: const Size.fromHeight(kToolbarHeight + 64).height,
        flexibleSpace: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 64),
          child: const Text(
            'Список\nинтересных мест',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            SightCard(
              sight: mocks[0],
            ),
            SightCard(
              sight: mocks[1],
            ),
          ],
        ),
      ),
    );
  }
}
