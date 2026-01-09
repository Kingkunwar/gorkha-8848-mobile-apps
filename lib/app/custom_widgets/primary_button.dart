import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/ease_in_widget.dart';

class PrimaryButton extends StatelessWidget {
  final bool isWidthLimited;
  final Function()? onTap;
  final String buttonTitle;
  final Color? buttonBackgroundColor;
  final EdgeInsets? padding;
  const PrimaryButton({
    super.key,
    this.isWidthLimited = false,
    required this.buttonTitle,
    this.buttonBackgroundColor,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return EaseInWidget(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 20.w,
            ),
        decoration: BoxDecoration(
          color: buttonBackgroundColor ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(50.r),
        ),
        width: isWidthLimited ? null : double.infinity,
        alignment: isWidthLimited ? null : Alignment.center,
        child: Text(
          buttonTitle,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
        ),
      ),
    );
  }
}
