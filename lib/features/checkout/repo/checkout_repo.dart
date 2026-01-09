import 'package:dartz/dartz.dart';
import 'package:restaurantapp/core/network/client/base_client.dart';
import 'package:restaurantapp/core/network/client/get_response_data.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';
import 'package:restaurantapp/features/checkout/models/discount_model.dart';

abstract class CheckoutRepo {
  Future<List<String>> fetchDeliveryTimes(String date);
  Future<Either<Success, Failure>> completeDeliveryOrder(
      Map<String, dynamic> body);

  Future<Either<DiscountModel, Failure>> fetchAvailableDiscount();
  Future<Either<Map<String, dynamic>, Failure>> fetchOrderDays();
}

class CheckoutImpl implements CheckoutRepo {
  final BaseClient _client;
  CheckoutImpl(this._client);
  @override
  Future<List<String>> fetchDeliveryTimes(String date) async {
    //date is in format mm/dd/yyyy
    final response = await _client.getRequest(
      path: "/ordertime?date=$date&type=home_delivery",
    );
    List<String> dateList = [];
    if (response?.statusCode == 200) {
      if (response?.data is Map) {
        Map<String, dynamic> dates = response!.data;
        for (var element in dates.keys) {
          dateList.add(element);
        }
      }
    }
    return dateList;
  }

  @override
  Future<Either<Success, Failure>> completeDeliveryOrder(
      Map<String, dynamic> body) async {
    final response = await _client.postRequest(
      path: "/complete-order",
      showDialog: true,
      data: body,
    );
    return getParsedData(
      response,
      Success.fromJson,
    );
  }

  @override
  Future<Either<DiscountModel, Failure>> fetchAvailableDiscount() async {
    final response = await _client.getRequest(
      path: "/check-discount",
    );
    return getParsedData(
      response,
      DiscountModel.fromJson,
    );
  }

  @override
  Future<Either<Map<String, dynamic>, Failure>> fetchOrderDays() async {
    final response = await _client.getRequest(
      path: "/orderday",
    );
    if (response?.statusCode == 200) {
      return Left(response!.data);
    } else {
      return Right(
        Failure(
          message: "Something went wrong.",
        ),
      );
    }
  }
}
