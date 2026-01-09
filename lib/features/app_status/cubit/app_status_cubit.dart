import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/features/app_status/repo/app_status_repo.dart';

class AppStatusCubit extends Cubit<AppStatusState> {
  final AppStatusRepo _repo;
  AppStatusCubit(this._repo) : super(AppStatusFetchingState());

  resetAppStatus() {
    emit(AppStatusFetchingState());
  }

  checkAppStatus() async {
    if (state is! AppRunningState) {
      emit(AppStatusFetchingState());
    }
    final response = await _repo.fetchAppStatus();

    response.fold(
      (l) => emit(
        AppRunningState(
          appStatus: l,
        ),
      ),
      (r) => emit(
        UnderMaintenanceState(
          message: "App under maintenance. Please try again later.",
        ),
      ),
    );
  }
}

abstract class AppStatusState {}

class AppStatusFetchingState extends AppStatusState {}

class AppRunningState extends AppStatusState {
  final AppStatusModel appStatus;
  AppRunningState({
    required this.appStatus,
  });
}

class UnderMaintenanceState extends AppStatusState {
  final String message;
  UnderMaintenanceState({
    required this.message,
  });
}

class AppStatusModel {
  String? cashOnDelivery;
  String? paymentStripe;
  bool? deliveryEnabled;
  bool? collectionEnabled;
  String? tableReservation;
  String? isMobileApiDisabled;
  String? mobileApiDisabledMessage;

  AppStatusModel({
    this.cashOnDelivery,
    this.paymentStripe,
    this.deliveryEnabled,
    this.collectionEnabled,
    this.tableReservation,
    this.isMobileApiDisabled,
    this.mobileApiDisabledMessage,
  });

  AppStatusModel.fromJson(Map<String, dynamic> json) {
    cashOnDelivery = json['cash_on_delivery'];
    paymentStripe = json['payment_mstripe'];
    deliveryEnabled = json['delivery_enabled'];
    collectionEnabled = json['collection_enabled'];
    tableReservation = json['table_reservation'];
    isMobileApiDisabled = json['is_mobile_api_disabled'] ?? "0";
    mobileApiDisabledMessage = json['mobile_api_disabled_message'];
  }
}
