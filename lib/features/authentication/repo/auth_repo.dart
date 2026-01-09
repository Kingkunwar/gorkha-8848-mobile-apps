import 'package:dartz/dartz.dart';
import 'package:restaurantapp/core/network/client/base_client.dart';
import 'package:restaurantapp/core/network/client/get_response_data.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';
import 'package:restaurantapp/features/authentication/models/signup_model.dart';
import 'package:restaurantapp/features/authentication/models/signup_response_model.dart';

abstract class AuthRepo {
  Future<Either<SignupResponseModel, Failure>> signUp(SignupModel userData);
  Future<Either<SignupResponseModel, Failure>> login(
    String email,
    String password,
  );
  Future<Either<Success, Failure>> changePassword(
    Map<String, dynamic> passwordBody,
  );
}

class AuthImpl implements AuthRepo {
  final BaseClient _client;
  AuthImpl(this._client);

  @override
  Future<Either<SignupResponseModel, Failure>> signUp(
    SignupModel userData,
  ) async {
    final response = await _client.postRequest(
      path: "/register",
      data: userData.toJson(),
    );
    return getParsedData(
      response,
      SignupResponseModel.fromJson,
    );
  }

  @override
  Future<Either<SignupResponseModel, Failure>> login(
      String email, String password) async {
    final response = await _client.postRequest(path: "/login", data: {
      "email": email,
      "password": password,
    });
    return getParsedData(
      response,
      SignupResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Success, Failure>> changePassword(
      Map<String, dynamic> passwordBody) async {
    final response = await _client.postRequest(
      path: "/password-change",
      data: passwordBody,
      showDialog: true,
    );
    return getParsedData(
      response,
      Success.fromJson,
    );
  }
}
