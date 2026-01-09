import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/features/meal_deals/bloc/meal_deal_bloc.dart';
import 'package:restaurantapp/features/meal_deals/model/meal_deal_model.dart';
import 'package:restaurantapp/features/meal_deals/widgets/new_test_widget.dart';

class MealDealWidget extends StatefulWidget {
  final MealDealFetchedState state;
  const MealDealWidget({
    super.key,
    required this.state,
  });

  @override
  State<MealDealWidget> createState() => _MealDealWidgetState();
}

class _MealDealWidgetState extends State<MealDealWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(
        height: 5.h,
      ),
      itemCount: widget.state.mealDeal.mealDealItems != null
          ? widget.state.mealDeal.mealDealItems!.length
          : 0,
      itemBuilder: (context, index) {
        MealDealHolder item = widget.state.mealDeal.mealDealItems![index];
        return Container(
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
              10.horizontalSpace,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.title ?? "",
                    ),
                    Text(
                      "Any ${item.title}",
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return TestWidget(
                        state: widget.state,
                        index: index,
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.menu,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
