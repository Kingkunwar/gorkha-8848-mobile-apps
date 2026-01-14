import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/core/constants/app_colors.dart';
import 'package:restaurantapp/core/extensions/cached_network_extension.dart';
import 'package:restaurantapp/features/indian_nepalese_food/model/indian_nepalese_food_model.dart';

class FoodPickerWidget extends StatelessWidget {
  final SubItem? item;
  final SubPrices? subPrices;
  final Function() onAddTapped;
  final bool hasMultipleItems;
  final IconData? newIcon;

  const FoodPickerWidget({
    super.key,
    required this.item,
    this.hasMultipleItems = false,
    this.subPrices,
    this.newIcon,
    required this.onAddTapped,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenPadding(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFCFCFCF),
              ),
            ),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: item?.imageUrl ?? "",
                  height: 90.h,
                  width: 90.w,
                  fit: BoxFit.cover,
                ).withPlaceHolder(),
                // Container(
                //   height: 90.w,
                //   width: 90.w,
                //   color: const Color(0xFFE3E1E1),
                // ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item?.title != null && subPrices?.title == null
                            ? item?.title ?? ""
                            : "${subPrices?.title} ${item?.title}",
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 100.w,
              ),
              Text(
                subPrices != null
                    ? "£${subPrices!.price}"
                    : item?.price != null
                        ? "£${item!.price}"
                        : '',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  onAddTapped();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                  padding: EdgeInsets.all(5.w),
                  child: Icon(
                    newIcon != null
                        ? newIcon!
                        : !hasMultipleItems
                            ? Icons.menu
                            : Icons.add,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );

    // return ListTile(
    //   title: Text(
    //     item.title ?? "",
    //     style: Theme.of(context).textTheme.bodyLarge,
    //   ),
    //   subtitle: Text(
    //     item.price ?? "",
    //     style: Theme.of(context).textTheme.bodyLarge,
    //   ),
    //   trailing: item.price != null
    //       ? EaseInWidget(
    //           onTap: () {
    //             BlocProvider.of<CartBloc>(context).add(
    //               AddItemToCartEvent(
    //                 cartItem: CartItemModel(
    //                   itemId: item.id.toString(),
    //                   price: item.price.toString(),
    //                   title: item.title ?? "",
    //                 ),
    //               ),
    //             );
    //             showToast(
    //               "Item added to cart",
    //             );
    //           },
    //           child: const Icon(
    //             Icons.add_circle,
    //           ),
    //         )
    //       : item.prices != null
    //           ? EaseInWidget(
    //               onTap: () {
    //                 showModalBottomSheet(
    //                   context: context,
    //                   builder: (context) {
    //                     return Column(
    //                       mainAxisSize: MainAxisSize.min,
    //                       children: item.prices != null
    //                           ? item.prices!
    //                               .map(
    //                                 (e) => ListTile(
    //                                   title: Text(
    //                                     e.title ?? "",
    //                                   ),
    //                                   subtitle: Text(
    //                                     e.price ?? "",
    //                                   ),
    //                                   trailing: EaseInWidget(
    //                                     onTap: () {
    //                                       BlocProvider.of<CartBloc>(context)
    //                                           .add(
    //                                         AddItemToCartEvent(
    //                                           cartItem: CartItemModel(
    //                                             itemId: e.id.toString(),
    //                                             price: e.price.toString(),
    //                                             title: e.title ?? "",
    //                                           ),
    //                                         ),
    //                                       );
    //                                       showToast(
    //                                         "Item added to cart",
    //                                       );
    //                                     },
    //                                     child: const Icon(
    //                                       Icons.add_circle,
    //                                     ),
    //                                   ),
    //                                 ),
    //                               )
    //                               .toList()
    //                           : [],
    //                     );
    //                   },
    //                 );
    //               },
    //               child: const Icon(
    //                 Icons.menu,
    //               ),
    //             )
    //           : const SizedBox(),
    // );
  }
}
