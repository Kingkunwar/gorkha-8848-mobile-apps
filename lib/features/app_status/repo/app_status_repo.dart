import 'package:dartz/dartz.dart';
import 'package:restaurantapp/core/network/client/base_client.dart';
import 'package:restaurantapp/core/network/client/get_response_data.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';
import 'package:restaurantapp/features/app_status/cubit/app_status_cubit.dart';

abstract class AppStatusRepo {
  Future<Either<AppStatusModel, Failure>> fetchAppStatus();
}

class AppStatusRepoImpl implements AppStatusRepo {
  final BaseClient _client;
  AppStatusRepoImpl(this._client);
  @override
  Future<Either<AppStatusModel, Failure>> fetchAppStatus() async {
    final response = await _client.getRequest(
      path: "/check-mobile-api-status",
      
    );
    return getParsedData(
      response,
      AppStatusModel.fromJson,
    );
  }
}
