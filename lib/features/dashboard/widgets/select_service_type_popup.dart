import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/features/cart/screens/cart_screen.dart';

class SelectServiceTypePopup extends StatelessWidget {
  final bool isDeliveryEnabled;
  final bool isCollectionEnabled;
  const SelectServiceTypePopup({
    super.key,
    required this.isCollectionEnabled,
    required this.isDeliveryEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 16.h),
        Text(
          "Please Select a service type",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 20.h),
        if (isDeliveryEnabled)
          _ServiceOption(
            title: "Delivery",
            icon: Icons.delivery_dining,
            onTap: () {
              Navigator.of(context).pop(ServiceType.delivery);
            },
          ),
        if (isDeliveryEnabled && isCollectionEnabled) SizedBox(height: 12.h),
        if (isCollectionEnabled)
          _ServiceOption(
            title: "Collection",
            icon: Icons.store,
            onTap: () {
              Navigator.of(context).pop(ServiceType.collection);
            },
          ),
        SizedBox(height: 16.h),
      ],
    );
  }
}

class _ServiceOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _ServiceOption({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
          child: Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 24.sp,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
