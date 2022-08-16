import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';

class HistoryListTile extends StatelessWidget {
  final String title;
  final VoidCallback? onClearTap;
  final GestureTapCallback? onTap;

  const HistoryListTile({
    Key? key,
    required this.title,
    required this.onClearTap,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: AppColors.secondary2Kit),
      ),
      trailing: IconButton(
        onPressed: onClearTap,
        icon: const Icon(
          Icons.clear,
          color: AppColors.secondary2Kit,
        ),
      ),
    );
  }
}
