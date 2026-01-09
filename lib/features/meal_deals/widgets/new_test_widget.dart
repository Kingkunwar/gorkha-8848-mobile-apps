import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/ease_in_widget.dart';
import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/functions/show_toast.dart';
import 'package:restaurantapp/features/cart/bloc/cart_bloc.dart';
import 'package:restaurantapp/features/cart/models/cart_item_model.dart';
import 'package:restaurantapp/features/meal_deals/bloc/meal_deal_bloc.dart';
import 'package:restaurantapp/features/meal_deals/model/meal_deal_model.dart';
import 'package:restaurantapp/features/meal_deals/widgets/chipped_container.dart';
import 'package:restaurantapp/features/meal_deals/widgets/meal_picker_widget.dart';

class TestWidget extends StatefulWidget {
  final MealDealFetchedState state;
  final int index;
  const TestWidget({
    super.key,
    required this.state,
    required this.index,
  });

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  String mainItem = '';
  String starter = '';
  String drink = '';
  String fourthItem = '';
  String fifthItem = '';

  String getTitle(int index) {
    return index == 1
        ? starter
        : index == 2
            ? drink
            : index == 0
                ? mainItem
                : index == 3
                    ? fourthItem
                    : index == 4
                        ? fifthItem
                        : "";
  }

  setValue(int newIndex, Items value) {
    setState(() {
      if (newIndex == 1) {
        starter = value.title ?? "";
      } else if (newIndex == 3) {
        fourthItem = value.title ?? "";
      } else if (newIndex == 0) {
        mainItem = value.title!;
      } else if (newIndex == 4) {
        fifthItem = value.title ?? "";
      } else {
        drink = value.title ?? "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: ScreenPadding(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.state.mealDeal.mealDealItems?[widget.index]
                              .title ??
                          "",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Text(
                    "£${widget.state.mealDeal.mealDealItems![widget.index].price.toString()}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              10.verticalSpace,
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.state.mealDeal.mealDealItems![widget.index]
                    .mealDealItems!.length,
                itemBuilder: (_, newIndex) {
                  MealDealItems item = widget.state.mealDeal
                      .mealDealItems![widget.index].mealDealItems![newIndex];
                  return item.options == 1
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  item.title ?? item.category?.title ?? "",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                            EaseInWidget(
                              onTap: () async {
                                final Items? value = await showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return MealPickerWidget(
                                      items: item.category!.items!.toList(),
                                      texts: const [],
                                    );
                                  },
                                );
                                if (value != null) {
                                  setValue(
                                    newIndex,
                                    value,
                                  );
                                }
                              },
                              child: ChippedContainer(
                                text: getTitle(newIndex),
                              ),
                            ),
                          ],
                        )
                      : Builder(
                          builder: (context) {
                            List<String> texts = widget
                                .state
                                .mealDeal
                                .mealDealItems![widget.index]
                                .mealDealItems![newIndex]
                                .item!
                                .split(",");
                            debugPrint(
                                "----------------------->${texts.length}");
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      item.title ?? item.category?.title ?? "",
                                      // widget
                                      //         .state
                                      //         .mealDeal
                                      //         .mealDealItems![widget.index]
                                      //         .mealDealItems![2]
                                      //         .title ??
                                      //     "",
                                    ),
                                  ],
                                ),
                                EaseInWidget(
                                  onTap: () async {
                                    final Items? value =
                                        await showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return MealPickerWidget(
                                          texts: texts,
                                          items: [],
                                        );
                                      },
                                    );
                                    if (value != null) {
                                      if (newIndex == 3) {
                                        setState(() {
                                          fourthItem = value.title ?? "";
                                        });
                                      } else if (newIndex == 4) {
                                        setState(() {
                                          fifthItem = value.title ?? "";
                                        });
                                      } else if (newIndex == 2) {
                                        setState(() {
                                          drink = value.title ?? "";
                                        });
                                      } else if (newIndex == 1) {
                                        setState(() {
                                          starter = value.title ?? "";
                                        });
                                      } else {
                                        setState(() {
                                          mainItem = value.title ?? "";
                                        });
                                      }
                                    }
                                  },
                                  child: ChippedContainer(
                                    text: getTitle(newIndex),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                },
              ),
              if ((mainItem.isNotEmpty &&
                      starter.isNotEmpty &&
                      drink.isNotEmpty &&
                      widget.state.mealDeal.mealDealItems![widget.index]
                              .mealDealItems!.length ==
                          3) ||
                  (mainItem.isNotEmpty &&
                      starter.isNotEmpty &&
                      drink.isNotEmpty &&
                      fourthItem.isNotEmpty &&
                      widget.state.mealDeal.mealDealItems![widget.index]
                              .mealDealItems!.length ==
                          4) ||
                  (mainItem.isNotEmpty &&
                      starter.isNotEmpty &&
                      drink.isNotEmpty &&
                      fourthItem.isNotEmpty &&
                      fifthItem.isNotEmpty &&
                      widget.state.mealDeal.mealDealItems![widget.index]
                              .mealDealItems!.length ==
                          5)) ...{
                ScreenPadding(
                  child: PrimaryButton(
                    onTap: () {
                      debugPrint("$mainItem $starter $drink");
                      BlocProvider.of<CartBloc>(context).add(AddItemToCartEvent(
                        cartItem: CartItemModel(
                          price: widget.state.mealDeal
                              .mealDealItems![widget.index].price!
                              .split("£")
                              .first,
                          title: "$mainItem\n $starter\n $drink $fourthItem",
                          itemId: widget
                              .state.mealDeal.mealDealItems![widget.index].id
                              .toString(),

                          //TODO: update cateogry id here
                          categoryId: widget
                              .state.mealDeal.mealDealItems![widget.index].id
                              .toString(),
                          qty: 1,
                          rate: widget.state.mealDeal
                              .mealDealItems![widget.index].price!
                              .split("£")
                              .first,
                        ),
                      ));
                      showToast("Item added to cart.");
                      Navigator.of(context).pop();
                    },
                    buttonTitle: "Add to cart",
                  ),
                )
              },
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
