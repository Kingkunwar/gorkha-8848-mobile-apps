import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';
import 'package:restaurantapp/features/checkout/repo/checkout_repo.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutRepo _repo;
  CheckoutCubit(this._repo) : super(CheckoutInitial());

  resetCheckoutDetails() {
    emit(CheckoutInitial());
  }

  completeOrder(Map<String, dynamic> json) async {
    if (state is CheckingOutState) return;
    emit(CheckingOutState());
    final response = await _repo.completeDeliveryOrder(json);
    emit(
      response.fold(
        (l) => CheckedOutState(
          message: l.message ?? "Order completed",
        ),
        (r) => CheckOutFailureState(
          failure: r,
        ),
      ),
    );
  }
}
