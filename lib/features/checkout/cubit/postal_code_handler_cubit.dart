import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/features/checkout/screens/checkout_screen.dart';

part 'postal_code_handler_state.dart';

class PostalCodeHandlerCubit extends Cubit<CheckoutViewModel?> {
  PostalCodeHandlerCubit() : super(null);

  setPostalCode({
    required String postalCode,
    required String address,
    required String deliveryCharge,
  }) {
    emit(
      CheckoutViewModel(
        address: address,
        postalCode: postalCode,
        deliveryCharge: deliveryCharge,
      ),
    );
  }

  resetPostalCode() {
    emit(null);
  }
}
