import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChippedContainer extends StatelessWidget {
  final String text;
  const ChippedContainer({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(
          5.r,
        ),
      ),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 5.w,
      ),
      child: Text(
        text.isEmpty ? "Please select an item" : text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
