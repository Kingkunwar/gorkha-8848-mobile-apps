import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/features/order_day/cubit/order_day_cubit.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDayCubit, OrderDayState>(
      builder: (context, state) {
        if (state is OrderDayFetchedState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                title: Text(
                  "Please select a date",
                ),
              ),
              ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  children: state.orderDays.keys
                      .map(
                        (e) => ListTile(
                          onTap: () {
                            Map<String, dynamic> value = {
                              "key": state.orderDays[e],
                              "value": e
                            };
                            Navigator.of(context).pop(value);
                          },
                          title: Text(
                            state.orderDays[e].toString(),
                          ),
                        ),
                      )
                      .toList()),
            ],
          );
        } else if (state is OrderDayFetchErrorState) {
          return Center(
            child: Text(
              state.failure.message!,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
