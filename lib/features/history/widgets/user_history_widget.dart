import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/custom_pull_to_refresh_widget.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/history/cubit/user_history_cubit.dart';
import 'package:restaurantapp/features/history/models/user_history_model.dart';

class UserHistoryWidget extends StatelessWidget {
  const UserHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserHistoryCubit, UserHistoryState>(
        builder: (context, state) {
      if (state is UserHistoryFetchingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is UserHistoryFetchErrorState) {
        return CustomPullToRefresh(
          onRefresh: () {
            locator<UserHistoryCubit>().fetchUserHistory();
          },
          child: Center(
            child: Text(
              state.failure.message!,
            ),
          ),
        );
      } else if (state is UserHistoryFetchedState) {
        List<Orderhistory> orderHistoryList =
            state.userHistory.orderhistory ?? [];
        return orderHistoryList.isEmpty
            ? const Center(
                child: Text("Nothing to show."),
              )
            : ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: 10.h,
                ),
                itemCount: orderHistoryList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Orderhistory history = orderHistoryList[index];
                  return Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Order Id: ${history.orderId}",
                            ),
                            const Spacer(),
                            Text(
                              history.orderDateTime != null
                                  ? history.orderDateTime
                                      .toString()
                                      .split(" ")
                                      .first
                                  : '',
                            ),
                          ],
                        ),
                        5.verticalSpace,
                        if (history.items != null)
                          Table(
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            columnWidths: const {
                              0: FlexColumnWidth(3),
                              1: FlexColumnWidth(1),
                              2: FlexColumnWidth(1),
                              3: FlexColumnWidth(1),
                            },
                            border: TableBorder.all(),
                            children: [
                              const TableRow(children: [
                                Text("Item"),
                                Text("Quantity"),
                                Text("Rate"),
                                Text("Total")
                              ]),
                              ...history.items!
                                  .map(
                                    (e) => TableRow(
                                      children: [
                                        Text(
                                          e.item ?? "",
                                        ),
                                        Text(
                                          "${e.qty}",
                                        ),
                                        Text(
                                          "${e.price}",
                                        ),
                                        Text(
                                          "${e.total}",
                                        )
                                      ],
                                    ),
                                  )
                                  .toList()
                            ],
                          ),
                        // Column(
                        //   children: history.items!
                        //       .map((e) => Row(
                        //             children: [
                        //               Text(
                        //                 e.item ?? "",
                        //               ),

                        //             ],
                        //           ))
                        //       .toList(),
                        // )
                      ],
                    ),
                  );
                },
              );
      }
      return const SizedBox();
    });
  }
}
