import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/features/cart/screens/cart_screen.dart';

class CurrentServiceTypeCubit extends Cubit<ServiceType> {
  CurrentServiceTypeCubit() : super(ServiceType.collection);

  setSeriveItem(ServiceType type) {
    emit(type);
  }

  resetCurrentServiceType() {
    emit(ServiceType.collection);
  }
}
