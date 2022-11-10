import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/ui/screen/add_place/add_place_settings.dart';
import 'package:places/ui/screen/add_place/widgets/cupertino_add_picture.dart';
import 'package:provider/provider.dart';

class Pictures extends StatefulWidget {
  const Pictures({Key? key}) : super(key: key);

  @override
  State<Pictures> createState() => _PicturesState();
}

class _PicturesState extends State<Pictures> {
  @override
  Widget build(BuildContext context) {
    final images = context.watch<AddPlaceSettings>().mockImages;
    final theme = Theme.of(context);

    final imageWidgets = images
        .map((image) => Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.up,
              onDismissed: (direction) =>
                  context.read<AddPlaceSettings>().removeImage(image),
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
                margin: const EdgeInsets.only(right: AppDimensions.margin16),
                child: _Image(image: image),
              ),
            ))
        .toList();

    return SizedBox(
      height: AppDimensions.imagePickerSize,
      child: ListView(
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
          ...imageWidgets,
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final String image;

  const _Image({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddPlaceSettings>(context, listen: false);

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
            onTap: () => provider.removeImage(image),
            child: SvgPicture.asset(
              AppAssets.clearWhite,
            ),
          ),
        ),
      ],
    );
  }
}
