import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';
import 'package:restaurantapp/features/checkout/repo/checkout_repo.dart';

part 'order_day_state.dart';

class OrderDayCubit extends Cubit<OrderDayState> {
  final CheckoutRepo _repo;
  OrderDayCubit(this._repo) : super(OrderDayInitial());

  fetchOrderDays() async {
    final response = await _repo.fetchOrderDays();
    emit(response.fold(
      (l) => OrderDayFetchedState(
        orderDays: l,
      ),
      (r) => OrderDayFetchErrorState(
        failure: r,
      ),
    ));
  }

  resetOrderDay() {
    emit(OrderDayInitial());
  }
}
