import 'package:dartz/dartz.dart';
import 'package:restaurantapp/core/network/client/base_client.dart';
import 'package:restaurantapp/core/network/client/get_response_data.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';
import 'package:restaurantapp/features/history/models/user_history_model.dart';

abstract class UserHistoryRepo {
  Future<Either<UserHistoryModel, Failure>> fetchUserHistory();
}

class UserHistoryImpl implements UserHistoryRepo {
  final BaseClient _client;
  UserHistoryImpl(this._client);
  @override
  Future<Either<UserHistoryModel, Failure>> fetchUserHistory() async {
    final response = await _client.postRequest(
      path: "/user-details",
      showDialog: false,
    );

    return getParsedData(
      response,
      UserHistoryModel.fromJson,
    );
  }
}
