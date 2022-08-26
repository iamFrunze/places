import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/ui/screen/add_sight/add_sight_settings.dart';
import 'package:provider/provider.dart';

class Pictures extends StatefulWidget {
  const Pictures({Key? key}) : super(key: key);

  @override
  State<Pictures> createState() => _PicturesState();
}

class _PicturesState extends State<Pictures> {
  @override
  Widget build(BuildContext context) {
    final images =
        Provider.of<AddSightSettings>(context, listen: true).mockImages;
    final provider = Provider.of<AddSightSettings>(context, listen: false);
    final theme = Theme.of(context);

    final imageWidgets = images
        .map((image) => Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.up,
              onDismissed: (direction) => provider.removeImage(image),
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
      height: 100,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            GestureDetector(
              onTap: provider.addImage,
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
    final provider = Provider.of<AddSightSettings>(context, listen: false);

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
