import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? titleHeader;
  final double leadingWidth;
  final double appBarHeight;

  const CustomAppBar({
    super.key,
    required this.backgroundColor,
    this.actions,
    this.leading,
    required this.leadingWidth,
    this.titleHeader,
    required this.appBarHeight,
  });

  @override
  Size get preferredSize => const Size.fromHeight(77);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleHeader,
      toolbarHeight: appBarHeight,
      leadingWidth: leadingWidth,
      leading: leading,
      actions: actions,
      backgroundColor: backgroundColor,
    );
  }
}
