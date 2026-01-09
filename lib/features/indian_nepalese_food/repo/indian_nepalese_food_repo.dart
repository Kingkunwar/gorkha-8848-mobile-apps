import 'package:dartz/dartz.dart';
import 'package:restaurantapp/core/network/client/base_client.dart';
import 'package:restaurantapp/core/network/client/get_response_data.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';
import 'package:restaurantapp/features/indian_nepalese_food/model/indian_nepalese_food_model.dart';

enum FoodType {
  pizzaAndSides,
  indianAndNepalese,
}

abstract class IndianNepaleseFoodRepo {
  Future<Either<IndianNepaleseFoodModel, Failure>> fetchFoodItems();
  Future<Either<IndianNepaleseFoodModel, Failure>> fetchPizzaAndSides();
}

class IndianNepaleseFoodImpl implements IndianNepaleseFoodRepo {
  final BaseClient _client;
  IndianNepaleseFoodImpl(this._client);

  @override
  Future<Either<IndianNepaleseFoodModel, Failure>> fetchFoodItems() async {
    final response = await _client.getRequest(
      path: "/indiannepalese-items",
    );
    return getParsedData(
      response,
      IndianNepaleseFoodModel.fromJson,
    );
  }

  @override
  Future<Either<IndianNepaleseFoodModel, Failure>> fetchPizzaAndSides() async {
    final response = await _client.getRequest(
      path: "/items",
    );
    return getParsedData(
      response,
      IndianNepaleseFoodModel.fromJson,
    );
  }
}
