import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/custom_text_tabbar_widget.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/functions/show_toast.dart';
import 'package:restaurantapp/features/cart/bloc/cart_bloc.dart';
import 'package:restaurantapp/features/cart/models/cart_item_model.dart';
import 'package:restaurantapp/features/indian_nepalese_food/bloc/indian_nepalese_food_bloc.dart';
import 'package:restaurantapp/features/indian_nepalese_food/model/indian_nepalese_food_model.dart';
import 'package:restaurantapp/features/pizza_and_sides/widgets/food_picker_widget.dart';
import 'package:restaurantapp/main.dart';

class PizzaAndSidesTabbarScreen extends StatefulWidget {
  final IndianNepaleseFoodFetchedState state;
  final Function() onRefresh;
  const PizzaAndSidesTabbarScreen({
    super.key,
    required this.onRefresh,
    required this.state,
  });

  @override
  State<PizzaAndSidesTabbarScreen> createState() =>
      _PizzaAndSidesTabbarScreenState();
}

class _PizzaAndSidesTabbarScreenState extends State<PizzaAndSidesTabbarScreen> {
  TabController? _controller;
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  List<Widget> tabItems = [];

  @override
  void initState() {
    if (widget.state.foodModel.foodItems != null) {
      tabItems = widget.state.foodModel.foodItems!
          .map(
            (e) => e.items?.subItems != null
                ? ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5.h,
                    ),
                    padding: EdgeInsets.zero,
                    itemCount: e.items!.subItems!.length,
                    // shrinkWrap: true,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      SubItem item = e.items!.subItems![index];
                      return FoodPickerWidget(
                        item: item,
                        hasMultipleItems: item.price != null,
                        onAddTapped: () {
                          if (item.price != null) {
                            BlocProvider.of<CartBloc>(context).add(
                              AddItemToCartEvent(
                                cartItem: CartItemModel(
                                  itemId: item.id.toString(),
                                  price: item.price.toString(),
                                  title: item.title ?? "",
                                  categoryId: item.categoryId.toString(),
                                  qty: 1,
                                  rate: item.price.toString(),
                                ),
                              ),
                            );
                            showToast("Item added to cart.");
                            // "Item Added to cart".toSnackBar(
                            //   action: cartSnackBarAction(),
                            // );
                            // showToast(
                            //   "Item added to cart",
                            //   // action: cartSnackBarAction(),
                            // );
                          } else if (item.prices != null) {
                            showModalBottomSheet(
                              context: context,
                              useSafeArea: true,
                              builder: (context) {
                                return SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      ScreenPadding(
                                        child: Text(
                                          "Please select an item(s)",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      ...item.prices != null
                                          ? item.prices!
                                              .map(
                                                (e) => FoodPickerWidget(
                                                  subPrices: e,
                                                  item: item,
                                                  newIcon: Icons.add,
                                                  hasMultipleItems: false,
                                                  onAddTapped: () {
                                                    BlocProvider.of<CartBloc>(
                                                            context)
                                                        .add(
                                                      AddItemToCartEvent(
                                                        cartItem: CartItemModel(
                                                          itemId:
                                                              e.id.toString(),
                                                          price: e.price
                                                              .toString(),
                                                          title:"${e.title} ${item.title}",
                                                          categoryId: item
                                                              .categoryId
                                                              .toString(),
                                                          qty: 1,
                                                          rate: item.price
                                                              .toString(),
                                                        ),
                                                      ),
                                                    );
                                                    showToast(
                                                        "Item added to cart.");
                                                    Navigator.of(navigatorKey
                                                            .currentContext!)
                                                        .pop();

                                                    // showToast(
                                                    //   "Item added to cart",
                                                    //   // action:
                                                    //   //     cartSnackBarAction(),
                                                    // );
                                                  },
                                                ),
                                              )
                                              .toList()
                                          : [],
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            showErrorToast("Something went wrong.");
                          }
                        },
                      );
                    },
                  )
                : const Text("Nothing found"),
          )
          .toList();
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.dispose();
    }
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _selectedIndex,
      builder: (context, index, child) {
        return CustomTabbarWidget(
          bodies: tabItems,
          titles: widget.state.foodModel.foodItems != null
              ? widget.state.foodModel.foodItems!
                  .map(
                    (e) => e.title ?? "",
                  )
                  .toList()
              : [],
        );
      },
    );
  }
}
