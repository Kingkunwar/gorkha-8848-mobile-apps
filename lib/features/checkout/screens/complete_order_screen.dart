import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
import 'package:restaurantapp/app/custom_widgets/ease_in_widget.dart';
import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/functions/get_background_decoration.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';
import 'package:restaurantapp/app/functions/show_toast.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/core/constants/restaurant_constants.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/cart/bloc/cart_bloc.dart';
import 'package:restaurantapp/features/cart/cubit/item_state_cubit.dart';
import 'package:restaurantapp/features/cart/cubit/subtotal_cubit.dart';
import 'package:restaurantapp/features/cart/screens/cart_screen.dart';
import 'package:restaurantapp/features/checkout/checkout_cubit/checkout_cubit.dart';
import 'package:restaurantapp/features/checkout/cubit/postal_code_handler_cubit.dart';
import 'package:restaurantapp/features/checkout/widgets/order_table_widget.dart';
import 'package:restaurantapp/features/payment/stripe/payment_functions.dart';
import 'package:restaurantapp/main.dart';

class CompleteOrderScreenViewModel {
  final Map<String, dynamic> body;
  final Map<String, dynamic> userDetails;

  CompleteOrderScreenViewModel({required this.body, required this.userDetails});
}

class CompleteOrderScreen extends StatefulWidget {
  final CompleteOrderScreenViewModel vm;
  const CompleteOrderScreen({super.key, required this.vm});

  @override
  State<CompleteOrderScreen> createState() => _CompleteOrderScreenState();
}

class _CompleteOrderScreenState extends State<CompleteOrderScreen> {
  bool _termsAndConditionsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator<CheckoutCubit>(),
      child: Scaffold(
        appBar: const CustomAppBar(title: "Checkout Details"),
        body: ScreenPadding(
          child: BlocBuilder<SubtotalCubit, SubTotalViewModel>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.verticalSpace,
                    for (var key in widget.vm.userDetails.keys) ...{
                      Text(
                        "$key: ${widget.vm.userDetails[key]}",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      5.verticalSpace,
                    },
                    10.verticalSpace,
                    const OrderTableWidget(),
                    10.verticalSpace,
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Sub total"),
                        10.horizontalSpace,
                        SizedBox(
                          width: 50.w,
                          child: Text(
                            "£${num.parse(state.total).toStringAsFixed(2)}",
                          ),
                        ),
                      ],
                    ),
                    if (state.discount.isNotEmpty &&
                        state.discount.toLowerCase() != "null" &&
                        state.discount != "0")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Discount (${state.discount}%)"),
                          10.horizontalSpace,
                          Builder(
                            builder: (context) {
                              num discount =
                                  (num.parse(state.discount) / 100) *
                                  num.parse(state.total);
                              return SizedBox(
                                width: 50.w,
                                child: Text("£${discount.toStringAsFixed(2)}"),
                              );
                            },
                          ),
                        ],
                      ),
                    if (locator<CurrentServiceTypeCubit>().state ==
                        ServiceType.delivery) ...{
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Delivery Charge"),
                          10.horizontalSpace,
                          SizedBox(
                            width: 50.w,
                            child: Text("£${state.deliveryCharge}"),
                          ),
                        ],
                      ),
                    },
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Total"),
                        10.horizontalSpace,
                        SizedBox(
                          width: 50.w,
                          child: Text("£${state.subTotal}"),
                        ),
                      ],
                    ),
                    const Divider(),
                    CheckboxListTile(
                      value: _termsAndConditionsAccepted,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("I agree to the "),
                          EaseInWidget(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.webViewScreen,
                                arguments:
                                    RestaurantConstants.termsAndConditionsUrl,
                              );
                            },
                            child: const Text(
                              "Terms & Conditions",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onChanged: (bool? val) {
                        if (val != null) {
                          setState(() {
                            _termsAndConditionsAccepted = val;
                          });
                        }
                      },
                    ),
                    BlocListener<CheckoutCubit, CheckoutState>(
                      listener: (context, state) {
                        if (state is CheckedOutState) {
                          locator<CartBloc>().add(ResetCartEvent());
                          locator<PostalCodeHandlerCubit>().resetPostalCode();
                          // showInfoDialog(
                          //     message: state.message,
                          //     customFunction: () {
                          pushAndRemoveUntil(
                            routeName: AppRoutes.orderCompletedScreen,
                          );
                          // });
                        } else if (state is CheckOutFailureState) {
                          showErrorToast(state.failure.message!);
                        }
                      },
                      child: PrimaryButton(
                        buttonTitle: "Complete Order",
                        onTap: () async {
                          if (!isLoggedIn()) {
                            pushNamed(
                              context: context,
                              routeName: AppRoutes.loginScreen,
                              arguments: widget.vm,
                            );
                          } else {
                            if (_termsAndConditionsAccepted) {
                              widget.vm.body.addAll({"device": "mobile"});

                              if (widget.vm.userDetails.containsKey(
                                    "Payment Method",
                                  ) &&
                                  widget.vm.userDetails['Payment Method']
                                          .toLowerCase() ==
                                      "card") {
                                String response = await StripeApi()
                                    .initPaymentSheet(state.subTotal);
                                if (response.isNotEmpty) {
                                  widget.vm.body.addAll({
                                    "stripe_token": response,
                                  });

                                  showToast("Payment successful");
                                  locator<CheckoutCubit>().completeOrder(
                                    widget.vm.body,
                                  );
                                } else {
                                  showToast("Payment failed");
                                }
                              } else {
                                locator<CheckoutCubit>().completeOrder(
                                  widget.vm.body,
                                );
                              }
                            } else {
                              showToast(
                                "You need to agree to the Terms and Conditions",
                              );
                            }
                          }
                        },
                      ),
                    ),
                    20.verticalSpace,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
