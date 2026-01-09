import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/features/checkout/models/discount_model.dart';
import 'package:restaurantapp/features/checkout/repo/checkout_repo.dart';

class DiscountCubit extends Cubit<DiscountModel> {
  final CheckoutRepo _repo;
  DiscountCubit(this._repo)
      : super(DiscountModel(
          discount: 0,
          discountOnDelivery: 0,
        ));

  resetDiscount() {
    emit(
      DiscountModel(
        discount: 0,
        discountOnDelivery: 0,
      ),
    );
  }

  // fetchDiscount() async {
  //   final response = await _repo.fetchAvailableDiscount();
  //   emit(
  //     response.fold(
  //       (l) => l,
  //       (r) {
  //         return DiscountModel(
  //           discount: 0,
  //           discountOnDelivery: 0,
  //         );
  //       },
  //     ),
  //   );
  // }

  setDiscount(
    num discountOnDelivery,
    num discount,
  ) {
    emit(
      DiscountModel(
        discountOnDelivery: discountOnDelivery,
        discount: discount,
      ),
    );
  }
}
