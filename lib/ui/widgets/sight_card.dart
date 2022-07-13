import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/app_resources.dart';

class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const marginInsets = 16.0;

    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        margin: const EdgeInsets.only(left: marginInsets, right: marginInsets, top: marginInsets),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Color(0xfff5f5f5),
        ),
        child: Column(
          children: [
            _ImageCardWidget(sight: sight),
            _TextCardWidget(sight: sight),
          ],
        ),
      ),
    );
  }
}

class _ImageCardWidget extends StatelessWidget {
  final Sight sight;

  const _ImageCardWidget({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const marginInsets = 16.0;

    return Hero(
      tag: 'imageHero',
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: Colors.greenAccent,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: marginInsets,
            right: marginInsets,
            left: marginInsets,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sight.type.toLowerCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              SvgPicture.asset(
                AppAssets.heart,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextCardWidget extends StatelessWidget {
  final Sight sight;

  const _TextCardWidget({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const marginInsets = 16.0;

    return Padding(
      padding: const EdgeInsets.all(marginInsets),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sight.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          Text(
            sight.details,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xff7C7E92),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
