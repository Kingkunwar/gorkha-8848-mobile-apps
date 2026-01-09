import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/ease_in_widget.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabBar? bottom;
  final Color? backgroundColor;
  final bool? shouldCenterTitle;
  final Widget? customLeadingWidget;
  final bool showBackArrow;
  final Function()? onBackTapped;
  final Widget? customTitle;
  final double? customTitleSpacing;
  final String? title;
  final List<Widget>? actions;
  final Color? iconColor;
  final TabBar? tabBar;
  final double? elevation;
  final double? leadingWidth;
  final double appbarHeight;
  final TextStyle? titleStyle;

  const CustomAppBar({
    Key? key,
    this.bottom,
    this.titleStyle,
    this.iconColor,
    this.onBackTapped,
    this.showBackArrow = true,
    this.customTitleSpacing,
    this.shouldCenterTitle = true,
    this.backgroundColor,
    this.leadingWidth,
    this.customLeadingWidget,
    this.title = "",
    this.actions,
    this.tabBar,
    this.customTitle,
    this.appbarHeight = 60,
    this.elevation = 0.1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget leadingWidget() {
      return Padding(
        padding: const EdgeInsets.all(
          10,
        ),
        child: EaseInWidget(
          onTap: () {
            onBackTapped != null
                ? onBackTapped!()
                : popPage(
                    context: context,
                  );
          },
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      );
    }

    return AppBar(
      leading: customLeadingWidget ?? (showBackArrow ? leadingWidget() : null),
      backgroundColor: backgroundColor,
      elevation: elevation,
      titleSpacing: customTitle != null ? customTitleSpacing : null,
      leadingWidth: leadingWidth,
      scrolledUnderElevation: 0,
      title: customTitle ??
          Text(
            title!,
            style: titleStyle ??
                TextStyle(
                  fontSize: 18.sp,
                ),
          ),
      centerTitle: shouldCenterTitle,
      actions: [
        if (actions != null) ...actions!,
        const SizedBox(
          width: 16,
        ),
      ],
      automaticallyImplyLeading: showBackArrow,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(bottom == null ? appbarHeight : 65.h);
// Size.fromHeight(appbarHeight.w);
}
