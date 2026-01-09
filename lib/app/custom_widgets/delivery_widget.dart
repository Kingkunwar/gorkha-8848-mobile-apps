import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/features/cart/cubit/item_state_cubit.dart';
import 'package:restaurantapp/features/cart/screens/cart_screen.dart';

class DeliveryMiddlewareWidget extends StatelessWidget {
  final Widget child;
  const DeliveryMiddlewareWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentServiceTypeCubit, ServiceType>(
        builder: (context, state) {
      if (state == ServiceType.delivery) {
        return child;
      }
      return const SizedBox();
    });
  }
}
