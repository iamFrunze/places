import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';

class SearchListTileWidget extends StatelessWidget {
  final String url;
  final String title;
  final String subtitle;
  final GestureTapCallback? onTap;

  const SearchListTileWidget({
    Key? key,
    required this.url,
    required this.title,
    required this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      leading: _ImageLoader(
        imgUrl: url,
      ),
      title: Text(
        title,
        style: theme.textTheme.titleSmall
            ?.copyWith(color: theme.colorScheme.onPrimary),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodyMedium
            ?.copyWith(color: AppColors.secondary2Kit),
      ),
    );
  }
}

class _ImageLoader extends StatelessWidget {
  final String imgUrl;

  const _ImageLoader({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      imageBuilder: (_, imageProvider) =>
          _ImageBuilder(imageProvider: imageProvider),
      progressIndicatorBuilder: (_, __, downloadProgress) =>
          const _ImagePlaceholder(),
      // ignore: implicit_dynamic_parameter
      errorWidget: (_, __, ___) => const _ImagePlaceholder(),
    );
  }
}

class _ImageBuilder extends StatelessWidget {
  final ImageProvider imageProvider;

  const _ImageBuilder({Key? key, required this.imageProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(
        AppDimensions.cornerRadius12,
      )),
      child: Image(
        image: imageProvider,
        fit: BoxFit.cover,
        width: AppDimensions.tileLeadingSize,
        height: AppDimensions.tileLeadingSize,
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: AppDimensions.tileLeadingSize,
      width: AppDimensions.tileLeadingSize,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
