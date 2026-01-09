import 'package:dartz/dartz.dart';
import 'package:restaurantapp/core/constants/restaurant_constants.dart';
import 'package:restaurantapp/core/network/client/base_client.dart';
import 'package:restaurantapp/core/network/client/get_response_data.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';
import 'package:restaurantapp/features/about/model/about_model.dart';

abstract class AboutRepo {
  Future<Either<AboutModel, Failure>> fetchAbout();
  Future<Either<Success, Failure>> contact(Map<String, dynamic> data);
}

class AboutImpl implements AboutRepo {
  final BaseClient _client;
  AboutImpl(this._client);
  @override
  Future<Either<AboutModel, Failure>> fetchAbout() async {
    final response = await _client.getRequest(
      path: "/about",
    );
    return getParsedData(
      response,
      AboutModel.fromJson,
    );
  }

  @override
  Future<Either<Success, Failure>> contact(Map<String, dynamic> data) async {
    final response = await _client.postRequest(
      path: "/contact",
      baseUrl: RestaurantConstants.baseUrl.replaceAll("/api", ""),
      data: data,
      showDialog: true,
    );
    return getParsedData(
      response,
      Success.fromJson,
    );
  }
}
