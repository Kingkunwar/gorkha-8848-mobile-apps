import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurantapp/app/custom_widgets/ease_in_widget.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/dialogs/custom_confirmation_dialog.dart';
import 'package:restaurantapp/core/constants/app_colors.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/cart/bloc/cart_bloc.dart';
import 'package:restaurantapp/features/cart/models/cart_item_model.dart';
import 'package:restaurantapp/features/cart/widgets/custom_padded_widget.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemHolder item;
  const CartItemWidget({
    super.key,
    required this.item,
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
                Container(
                  height: 90.w,
                  width: 90.w,
                  color: const Color(0xFFE3E1E1),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      5.verticalSpace,
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          EaseInWidget(
                            debounceDuration: 0,
                            onTap: () {
                              BlocProvider.of<CartBloc>(context).add(
                                RemoveItemFromCart(
                                  cartItemId: item.item.itemId,
                                ),
                              );
                            },
                            child: CustomPaddedWidget(
                              child: Icon(
                                FontAwesomeIcons.minus,
                                color: Colors.black,
                                size: 12.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            item.totalItemCount.toString(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          EaseInWidget(
                            debounceDuration: 0,
                            onTap: () {
                              BlocProvider.of<CartBloc>(context).add(
                                AddItemToCartEvent(
                                  cartItem: CartItemModel(
                                    price: item.item.price,
                                    title: item.item.title,
                                    itemId: item.item.itemId,
                                    categoryId: item.item.categoryId,
                                    qty: item.item.qty,
                                    rate: item.item.rate,
                                  ),
                                ),
                              );
                            },
                            child: CustomPaddedWidget(
                              child: Icon(
                                FontAwesomeIcons.plus,
                                color: Colors.black,
                                size: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
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
                "£${item.item.price}",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
              ),
              const Spacer(),
              EaseInWidget(
                onTap: () async {
                  final bool confirmation = await getConfirmationDialog(
                      title: "Do you want to remove this item from cart ?");
                  if (confirmation) {
                    locator<CartBloc>().add(
                      RemoveWholeItemFromCart(
                        cartItem: item.item,
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                  padding: EdgeInsets.all(5.w),
                  child: const Icon(
                    FontAwesomeIcons.trashCan,
                    color: Colors.white,
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
    //     item.item.title,
    //   ),
    //   subtitle: Text(
    //     "£${(num.parse(item.item.price) * item.totalItemCount).toString()}",
    //   ),
    //   trailing: Row(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       IconButton(
    //         onPressed: () {
    //           BlocProvider.of<CartBloc>(context).add(
    //             RemoveItemFromCart(
    //               cartItemId: item.item.itemId,
    //             ),
    //           );
    //         },
    //         icon: const Icon(
    //           Icons.remove_circle,
    //         ),
    //       ),
    //       Text(
    //         item.totalItemCount.toString(),
    //       ),
    //       IconButton(
    //         onPressed: () {
    //           BlocProvider.of<CartBloc>(context).add(
    //             AddItemToCartEvent(
    //               cartItem: CartItemModel(
    //                 price: item.item.price,
    //                 title: item.item.title,
    //                 itemId: item.item.itemId,
    //               ),
    //             ),
    //           );
    //         },
    //         icon: const Icon(
    //           Icons.add_circle,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
