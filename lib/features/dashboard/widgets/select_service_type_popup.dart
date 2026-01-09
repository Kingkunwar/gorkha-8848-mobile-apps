import 'package:flutter/cupertino.dart';
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
        SizedBox(
          height: 15.h,
        ),
        Text(
          "Please Select a service type",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        10.verticalSpace,
        if (isDeliveryEnabled)
          CupertinoListTile(
            onTap: () {
              Navigator.of(context).pop(
                ServiceType.delivery,
              );
            },
            title: const Text("Delivery"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
        if (isDeliveryEnabled && isCollectionEnabled) const Divider(),
        if (isCollectionEnabled)
          CupertinoListTile(
            onTap: () {
              Navigator.of(context).pop(
                ServiceType.collection,
              );
            },
            title: const Text("Collection"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
        10.verticalSpace,
      ],
    );
  }
}
