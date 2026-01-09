import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/custom_pull_to_refresh_widget.dart';
import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/core/constants/asset_source.dart';
import 'package:restaurantapp/core/extensions/cached_network_extension.dart';
import 'package:restaurantapp/features/indian_nepalese_food/bloc/indian_nepalese_food_bloc.dart';
import 'package:restaurantapp/features/indian_nepalese_food/model/indian_nepalese_food_model.dart';

class IndianNepaleseFoodWidget extends StatelessWidget {
  final IndianNepaleseFoodFetchedState state;
  final Function() onRefresh;
  const IndianNepaleseFoodWidget({
    super.key,
    required this.state,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenPadding(
      child: CustomPullToRefresh(
        onRefresh: () {
          onRefresh();
        },
        child: ListView.builder(
          itemCount: state.foodModel.foodItems?.length,
          itemBuilder: (context, index) {
            ItemModel foodItem = state.foodModel.foodItems![index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foodItem.title ?? "",
                ),
                if (foodItem.items?.subItems != null)
                  Wrap(
                    spacing: 0.1.sw - 20.w,
                    children: foodItem.items!.subItems!
                        .map((e) => SizedBox(
                              width: 0.45.sw,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: AssetSource.customImage,
                                  ).withPlaceHolder(),
                                  Text(
                                    e.title ?? "",
                                  ),
                                  Text(
                                    e.details ?? "",
                                  ),
                                  const PrimaryButton(
                                    buttonTitle: "Add to cart",
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
