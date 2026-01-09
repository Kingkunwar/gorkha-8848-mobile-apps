import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';
import 'package:restaurantapp/app/functions/show_toast.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/core/constants/app_colors.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/cart/bloc/cart_bloc.dart';
import 'package:restaurantapp/features/cart/cubit/item_state_cubit.dart';
import 'package:restaurantapp/features/cart/cubit/subtotal_cubit.dart';
import 'package:restaurantapp/features/cart/models/cart_item_model.dart';
import 'package:restaurantapp/features/cart/widgets/cart_item_widget.dart';
import 'package:restaurantapp/features/checkout/cubit/postal_code_handler_cubit.dart';
import 'package:restaurantapp/features/checkout/discount_cubit/discount_cubit.dart';
import 'package:restaurantapp/features/checkout/models/discount_model.dart';
import 'package:restaurantapp/features/checkout/screens/checkout_screen.dart';
import 'package:restaurantapp/features/checkout/screens/complete_order_screen.dart';
import 'package:restaurantapp/features/dashboard/widgets/footer_widget.dart';
import 'package:restaurantapp/features/settings/models/settings_model.dart';
import 'package:restaurantapp/main.dart';

enum ServiceType {
  delivery,
  collection,
}

num getTotalPrice(List<CartItemHolder> state) {
  num total = 0;
  for (var item in state) {
    total += item.totalItemCount * num.parse(item.item.price);
  }
  return num.parse(total.toStringAsFixed(2));
}

class CartScreen extends StatefulWidget {
  final CheckoutViewModel? checkoutViewModel;

  const CartScreen({
    super.key,
    this.checkoutViewModel,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentServiceTypeCubit, ServiceType>(
      builder: (context, serviceType) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: "My Cart",
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: BlocBuilder<CartBloc, List<CartItemHolder>>(
            builder: (context, state) {
              return state.isEmpty
                  ? const SizedBox()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: PrimaryButton(
                          buttonTitle: "Checkout",
                          isWidthLimited: true,
                          onTap: () async {
                            // if (isLoggedIn()) {
                            if (isLoggedIn()) {
                              debugPrint(
                                  "Minimum order for delivery is ${DeliveryConstants.minOrderForDelivery}");
                              if (locator<CurrentServiceTypeCubit>().state ==
                                      ServiceType.delivery &&
                                  getTotalPrice(state) <
                                      DeliveryConstants.minOrderForDelivery) {
                                showErrorToast(
                                  "Minimum order for delivery: £${DeliveryConstants.minOrderForDelivery}",
                                );
                              } else {
                                var state =
                                    locator<PostalCodeHandlerCubit>().state;

                                pushNamed(
                                  context: context,
                                  routeName: AppRoutes.checkoutScreen,
                                  arguments: state,
                                );
                              }
                            } else {
                              Navigator.of(context).pushNamed(
                                AppRoutes.loginScreen,
                                arguments: CompleteOrderScreenViewModel(
                                  body: {},
                                  userDetails: {},
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    );
            },
          ),
          body: BlocBuilder<CartBloc, List<CartItemHolder>>(
            builder: (context, state) {
              return state.isEmpty
                  ? Column(
                      children: [
                        const Expanded(
                          child: Center(
                            child: Text(
                              "Your cart is empty.",
                            ),
                          ),
                        ),
                        FooterWidget(),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        if (locator<CurrentServiceTypeCubit>().state ==
                                ServiceType.delivery &&
                            DeliveryConstants.minOrderForDelivery > 0) ...[
                          ScreenPadding(
                            child: Text(
                              "Minimum order for delivery: £${DeliveryConstants.minOrderForDelivery}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.primaryColor,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                        ],
                        if (locator<CurrentServiceTypeCubit>().state ==
                                ServiceType.delivery &&
                            DeliveryConstants.discountPercentageOnDelivery >
                                0 &&
                            DeliveryConstants.minimumAmountForDiscountDelivery >
                                0) ...[
                          ScreenPadding(
                            child: Text(
                              "${DeliveryConstants.discountPercentageOnDelivery}% discount over £${DeliveryConstants.minimumAmountForDiscountDelivery} on the delivery.",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.primaryColor,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                        ],
                        BlocBuilder<PostalCodeHandlerCubit, CheckoutViewModel?>(
                          builder: (context, settings) {
                            num deliveryCharge =
                                num.parse(settings?.deliveryCharge ?? "0");

                            locator<SubtotalCubit>().updateDeliveryCharge(
                                deliveryCharge.toString());
                            return BlocBuilder<DiscountCubit, DiscountModel>(
                              builder: (context, discount) {
                                return Expanded(
                                  child: Builder(builder: (context) {
                                    num total = getTotalPrice(state);

                                    locator<SubtotalCubit>()
                                        .updateTotal(total.toString());

                                    String subTotal = getSubTotal(
                                      discountOnDelivery:
                                          getDiscountPercentage(total),
                                      total: total,
                                      deliveryCharge: deliveryCharge,
                                    ).toStringAsFixed(2);
                                    locator<SubtotalCubit>()
                                        .updateSubTotal(subTotal);
                                    return ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          5.verticalSpace,
                                      padding: EdgeInsets.zero,
                                      itemCount:
                                          locator<CurrentServiceTypeCubit>()
                                                      .state ==
                                                  ServiceType.collection
                                              ? state.length + 3
                                              : state.length + 4,
                                      shrinkWrap: true,
                                      itemBuilder: (_, index) {
                                        return index > state.length + 2 ||
                                                (index > state.length + 1 &&
                                                    locator<CurrentServiceTypeCubit>()
                                                            .state ==
                                                        ServiceType.collection)
                                            ? Builder(
                                                builder: (context) {
                                                  return ScreenPadding(
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Total",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge!
                                                                .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                          Text(
                                                            "£$subTotal",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge!
                                                                .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                        ]),
                                                  );
                                                },
                                              )
                                            : index > state.length + 1
                                                ? ScreenPadding(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                            "Delivery Charge"),
                                                        Text(
                                                          "£$deliveryCharge",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : index > state.length
                                                    ? Builder(
                                                        builder: (context) {
                                                        String kDiscount =
                                                            getDiscountPercentage(
                                                                    total)
                                                                .toString();
                                                        locator<SubtotalCubit>()
                                                            .updateDiscount(
                                                                kDiscount);
                                                        num dis = ((num.parse(
                                                                    kDiscount) /
                                                                100) *
                                                            total);
                                                        return dis == 0
                                                            ? const SizedBox()
                                                            : ScreenPadding(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        "Discount ($kDiscount%):"),
                                                                    Text(
                                                                      "£${dis.toStringAsFixed(2)}",
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyLarge,
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                      })
                                                    : index == state.length
                                                        ? ScreenPadding(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Sub total",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyLarge!
                                                                      .copyWith(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                ),
                                                                Text(
                                                                  "£${total.toStringAsFixed(2)}",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyLarge!
                                                                      .copyWith(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : CartItemWidget(
                                                            item: state[index],
                                                          );
                                      },
                                    );
                                  }),
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        FooterWidget()
                      ],
                    );
            },
          ),
        );
      },
    );
  }
}

num getDiscountPercentage(num subTotal) {
  if (locator<CurrentServiceTypeCubit>().state == ServiceType.collection) {
    return subTotal > DeliveryConstants.minimumAmountForDiscountCollection
        ? DeliveryConstants.discountPercentageOnCollection
        : 0;
  } else {
    if (subTotal > DeliveryConstants.minimumAmountForDiscountDelivery) {
      return DeliveryConstants.discountPercentageOnDelivery;
    }
    return 0;
  }
}
