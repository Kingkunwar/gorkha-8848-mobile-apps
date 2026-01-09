import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/features/cart/bloc/cart_bloc.dart';
import 'package:restaurantapp/features/cart/models/cart_item_model.dart';

class OrderTableWidget extends StatelessWidget {
  const OrderTableWidget({super.key});

  TableRow _getTitleRow() {
    return const TableRow(
      children: [
        Text(
          "S.N.",
        ),
        Text(
          "Product",
        ),
        Text(
          "Qty",
        ),
        Text(
          "Price",
        ),
        Text(
          "Total",
        ),
      ],
    );
  }

  TableRow _getDiscountRows(String subtotal) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
        ),
      ),
      children: [
        const SizedBox(),
        const SizedBox(),
        const SizedBox(),
        const Text(
          "Sub Total",
        ),
        Text(
          subtotal,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, List<CartItemHolder>>(
        builder: (context, state) {
      if (state.isNotEmpty) {
        // return DataTable(columns: columns, rows: );
        return Table(
          // border: TableBorder.all(),
          columnWidths: const {
            0: FlexColumnWidth(0.8),
            1: FlexColumnWidth(3.8),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,

          children: [
            _getTitleRow(),
            ...state
                .map(
                  (e) => TableRow(
                    children: [
                      Text("${state.indexOf(e) + 1}"),
                      Text(
                        e.item.title,
                      ),
                      Text(e.totalItemCount.toString()),
                      Text(e.item.price),
                      Text(
                        (num.parse(e.item.price) *
                                num.parse(e.totalItemCount.toString()))
                            .toStringAsFixed(2),
                      )
                    ],
                  ),
                )
                .toList(),
            // _getDiscountRows(),
          ],
        );
      }
      return const Text(
        "Nothing to show",
      );
    });
  }
}
