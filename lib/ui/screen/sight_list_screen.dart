import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: customAppBar(),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Hello'),
            TextField(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget customAppBar() => AppBar(
        toolbarHeight: const Size.fromHeight(kToolbarHeight + 64).height,
        flexibleSpace: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 64),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'С',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    TextSpan(text: 'писок\n'),
                  ],
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'и',
                      style: TextStyle(
                        color: Colors.yellow,
                      ),
                    ),
                    TextSpan(text: 'нтересных мест'),
                  ],
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      );
}
