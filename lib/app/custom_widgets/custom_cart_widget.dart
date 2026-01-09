import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/ease_in_widget.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/features/cart/bloc/cart_bloc.dart';
import 'package:restaurantapp/features/cart/models/cart_item_model.dart';

class CustomCartWidget extends StatelessWidget {
  final Color? cartColor;
  const CustomCartWidget({
    super.key,
    this.cartColor,
  });

  @override
  Widget build(BuildContext context) {
    return EaseInWidget(
      onTap: () {
        pushNamed(
          routeName: AppRoutes.cartScreen,
          context: context,
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            Icons.shopping_cart,
            color: cartColor,
          ),
          Positioned(
            top: -12,
            right: -10,
            child: Container(
              padding: EdgeInsets.all(
                5.w,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: BlocBuilder<CartBloc, List<CartItemHolder>>(
                builder: (context, state) {
                  int count = 0;
                  for (var item in state) {
                    count += item.totalItemCount;
                  }
                  // int count = state.forEach((e) => e.totalItemCount );
                  return Text(
                    // state.length.toString(),
                    count.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
