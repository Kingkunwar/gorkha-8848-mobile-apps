import 'package:dartz/dartz.dart';
import 'package:restaurantapp/core/network/client/base_client.dart';
import 'package:restaurantapp/core/network/client/get_response_data.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';
import 'package:restaurantapp/features/settings/models/settings_model.dart';

abstract class SettingsRepo {
  Future<Either<SettingsModel, Failure>> fetchSettings();
}

class SettingsImpl implements SettingsRepo {
  final BaseClient _client;
  SettingsImpl(this._client);
  @override
  Future<Either<SettingsModel, Failure>> fetchSettings() async {
    final response = await _client.getRequest(
      path: "/settings",
    );
    return getParsedData(
      response,
      SettingsModel.fromJson,
    );
  }
}
