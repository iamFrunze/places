import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final PreferredSizeWidget? bottomWidget;

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottomWidget != null ? bottomWidget!.preferredSize.height : 0),
      );

  const AppBarWidget({
    Key? key,
    required this.title,
    this.bottomWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      bottom: bottomWidget,
    );
  }
}
