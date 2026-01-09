import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/features/cart/bloc/cart_bloc.dart';
import 'package:restaurantapp/features/cart/models/cart_item_model.dart';

class FloatingCartWidget extends StatelessWidget {
  const FloatingCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, List<CartItemHolder>>(
      builder: (context, state) {
        if (state.isNotEmpty) {
          return FloatingActionButton(
            onPressed: () {
              pushNamed(
                context: context,
                routeName: AppRoutes.cartScreen,
              );
            },
            child: const Icon(
              Icons.shopping_cart,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
