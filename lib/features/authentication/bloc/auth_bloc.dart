import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/core/constants/app_constants.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/authentication/models/signup_model.dart';
import 'package:restaurantapp/features/authentication/models/signup_response_model.dart';
import 'package:restaurantapp/features/authentication/repo/auth_repo.dart';
import 'package:restaurantapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _repo;
  AuthBloc(this._repo) : super(AuthInitial()) {
    on<LogoutEvent>(
      (event, emit) => emit(AuthInitial()),
    );
    on<UserRegistrationEvent>((event, emit) async {
      final response = await _repo.signUp(
        event.userData,
      );
      emit(
        response.fold(
          (l) {
            locator<SharedPreferences>().setString(
              AppConstants.currentUser,
              jsonEncode(
                l.user?.toJson(),
              ),
            );
            locator<SharedPreferences>().setString(
              AppConstants.bearerToken,
              l.accessToken ?? "",
            );
            locator<SharedPreferences>().setString(
              AppConstants.userEmail,
              event.userData.email,
            );
            locator<SharedPreferences>().setString(
              AppConstants.userEmail,
              event.userData.email,
            );
            return UserLoggedInState(
              signupResponse: l,
            );
          },
          (r) => AuthFailureState(
            failure: r,
          ),
        ),
      );
    });
    on<UserLoginEvent>((event, emit) async {
      emit(UserLoggingInState());
      debugPrint(state.toString());
      final response = await _repo.login(
        event.email,
        event.password,
      );

      try {
        response.fold(
          (l) {
            locator<SharedPreferences>().setString(
                AppConstants.currentUser,
                jsonEncode(
                  l.user?.toJson(),
                ));
            locator<SharedPreferences>().setString(
              AppConstants.bearerToken,
              l.accessToken ?? "",
            );
            locator<SharedPreferences>().setString(
              AppConstants.userEmail,
              event.email,
            );
            debugPrint("Reached");
            emit(
              UserLoggedInState(
                signupResponse: l,
              ),
            );
          },
          (r) => emit(
            AuthFailureState(
              failure: r,
            ),
          ),
        );
      } catch (e) {
        debugPrint(e.toString());
      }
      debugPrint(state.toString());
    });
    on<AuthenticationCheckEvent>((event, emit) async {
      String? user =
          locator<SharedPreferences>().getString(AppConstants.currentUser);

      if (user != null) {
        emit(
          UserLoggedInState(
            signupResponse: SignupResponseModel(
              user: UserModel.fromJson(
                jsonDecode(user),
              ),
              accessToken: locator<SharedPreferences>().getString(
                AppConstants.bearerToken,
              ),
            ),
          ),
        );
      } else {
        emit(AuthInitial());
      }
      debugPrint(state.toString());
    });
  }
}
