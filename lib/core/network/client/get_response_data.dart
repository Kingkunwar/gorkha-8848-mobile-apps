import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';

List<int> successStatusCodes = [200, 201, 202];

Future<Either<T, Failure>> getParsedData<T>(
    Response? response, dynamic fromJson) async {
  if (response != null && successStatusCodes.contains(response.statusCode)) {
    //handle success here
    try {
      return Left(fromJson(response.data));
    } catch (e, stackTrace) {
      debugPrint("error parsing data: $e $stackTrace");
      return Right(Failure.fromJson({}));
    }
  } else {
    try {
      return Right(
        Failure.fromJson(
          response?.data ?? {},
        ),
      );
    } catch (e) {
      return Right(
        Failure.fromJson(
          {},
        ),
      );
    }
  }
}
