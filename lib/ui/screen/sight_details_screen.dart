import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/app_resources.dart';

class SightDetailsScreen extends StatelessWidget {
  final Sight sight;

  const SightDetailsScreen({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: 'imageHero',
                    child: Container(
                      height: 400,
                      color: Colors.blue,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 36, left: 16),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      iconSize: 24,
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sight.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text(
                          sight.type.toLowerCase(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          'закрыто до 09:00'.toLowerCase(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff7c7e92),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      sight.details,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      height: 48,
                      width: double.maxFinite,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        label: const Text(
                          AppStrings.btnRoute,
                        ),
                        icon: SvgPicture.asset(AppAssets.route),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton.icon(
                          onPressed: null,
                          style: TextButton.styleFrom(primary: Colors.black),
                          label: const Text(
                            AppStrings.plan,
                          ),
                          icon: SvgPicture.asset(AppAssets.calendar),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          style: TextButton.styleFrom(primary: Colors.black),
                          label: const Text(
                            AppStrings.addToFavourite,
                          ),
                          icon: SvgPicture.asset(AppAssets.heart),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
