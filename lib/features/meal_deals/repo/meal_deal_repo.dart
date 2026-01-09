import 'package:dartz/dartz.dart';
import 'package:restaurantapp/core/network/client/base_client.dart';
import 'package:restaurantapp/core/network/client/get_response_data.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';
import 'package:restaurantapp/features/meal_deals/model/meal_deal_model.dart';

abstract class MealDealRepo {
  Future<Either<MealDealModel, Failure>> fetchMealDeals();
}

class MealDealImpl implements MealDealRepo {
  final BaseClient _client;
  MealDealImpl(this._client);
  @override
  Future<Either<MealDealModel, Failure>> fetchMealDeals() async {
    final response = await _client.getRequest(
      path: "/mealdeals",
    );
    return getParsedData(
      response,
      MealDealModel.fromJson,
    );
  }
}
