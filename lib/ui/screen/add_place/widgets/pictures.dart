import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/ui/screen/add_place/widgets/cupertino_add_picture.dart';

class Pictures extends StatefulWidget {
  final Stream<List<String>> streamImages;
  final Function(String image) removeImage;

  const Pictures({
    Key? key,
    required this.streamImages,
    required this.removeImage,
  }) : super(key: key);

  @override
  State<Pictures> createState() => _PicturesState();
}

class _PicturesState extends State<Pictures> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<List<String>>(
      stream: widget.streamImages,
      builder: (ctx, snapshot) {
        final images = snapshot.data;

        return SizedBox(
          height: AppDimensions.imagePickerSize,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: () async => showDialog(
                  context: context,
                  builder: (context) => const CupertinoAddImage(),
                ),
                child: Container(
                  height: AppDimensions.imagePickerSize,
                  width: AppDimensions.imagePickerSize,
                  margin: const EdgeInsets.only(right: AppDimensions.margin16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.colorScheme.tertiary.withOpacity(0.48),
                      width: AppDimensions.borderWidth2,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppDimensions.cornerRadius12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.margin16),
                    child: SvgPicture.asset(
                      AppAssets.plus,
                      fit: BoxFit.fitWidth,
                      color: theme.colorScheme.tertiary,
                    ),
                  ),
                ),
              ),
              ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images != null ? images.length : 0,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  final image =
                      images != null ? images[index] : AppAssets.placeholder;

                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.up,
                    onDismissed: (direction) => widget.removeImage(image),
                    background: Column(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        SvgPicture.asset(
                          AppAssets.dismissible,
                          color: theme.brightness == Brightness.light
                              ? AppColors.lmMainColorKit
                              : AppColors.dmWhiteColorKit,
                        ),
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: AppDimensions.margin16,
                      ),
                      child: _Image(
                        image: image,
                        removeImage: widget.removeImage,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Image extends StatelessWidget {
  final String image;
  final Function(String image) removeImage;

  const _Image({
    Key? key,
    required this.image,
    required this.removeImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: AppDimensions.imagePickerSize,
          width: AppDimensions.imagePickerSize,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(AppDimensions.cornerRadius12),
            ),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.colorBurn,
              color: const Color(0xFF252849).withOpacity(0.24),
              errorBuilder: (context, image, stackTrace) => const ColoredBox(
                color: Colors.red,
                child: Text(
                  '404',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress == null
                    ? child
                    : Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
              },
            ),
          ),
        ),
        Positioned(
          right: 1,
          child: GestureDetector(
            onTap: () => removeImage(image),
            child: SvgPicture.asset(
              AppAssets.clearWhite,
            ),
          ),
        ),
      ],
    );
  }
}
