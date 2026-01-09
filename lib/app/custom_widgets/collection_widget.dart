import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/features/cart/cubit/item_state_cubit.dart';
import 'package:restaurantapp/features/cart/screens/cart_screen.dart';

class CollectionMiddlewareWidget extends StatelessWidget {
  final Widget child;
  const CollectionMiddlewareWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentServiceTypeCubit, ServiceType>(
        builder: (context, state) {
      if (state == ServiceType.collection) {
        return child;
      }
      return const SizedBox();
    });
  }
}
