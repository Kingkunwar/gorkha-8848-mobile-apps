// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

class SubtotalCubit extends Cubit<SubTotalViewModel> {
  SubtotalCubit()
      : super(
          SubTotalViewModel(
            deliveryCharge: "",
            subTotal: "",
            discount: "",
            total: "",
          ),
        );

  resetSubTotal() {
    emit(
      SubTotalViewModel(
        deliveryCharge: "",
        subTotal: "",
        discount: "",
        total: "",
      ),
    );
  }

  updateDeliveryCharge(String deliveryCharge) {
    emit(
      state.copyWith(
        deliveryCharge: deliveryCharge,
      ),
    );
  }

  updateSubTotal(String subTotal) {
    emit(state.copyWith(subTotal: subTotal));
  }

  updateDiscount(String discount) {
    emit(state.copyWith(discount: discount));
  }

  updateTotal(String total) {
    emit(state.copyWith(total: total));
  }
}

class SubTotalViewModel {
  String deliveryCharge;
  String subTotal;
  String total;
  String discount;

  SubTotalViewModel({
    required this.deliveryCharge,
    required this.subTotal,
    required this.discount,
    required this.total,
  });

  SubTotalViewModel copyWith({
    String? deliveryCharge,
    String? subTotal,
    String? total,
    String? discount,
  }) {
    return SubTotalViewModel(
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      subTotal: subTotal ?? this.subTotal,
      total: total ?? this.total,
      discount: discount ?? this.discount,
    );
  }
}
