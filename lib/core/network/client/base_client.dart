import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:restaurantapp/app/dialogs/loading_dialog.dart';
import 'package:restaurantapp/core/constants/restaurant_constants.dart';
import 'package:restaurantapp/core/network/client/header.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseClient {
  Future<Response<dynamic>?> getRequest({
    String baseUrl = RestaurantConstants.baseUrl,
    Map<String, String>? optionalHeaders,
    Map<String, dynamic>? queryParameters,
    required String path,
    bool showDialog = false,
    bool shouldCache = true,
  });
  Future<Response<dynamic>?> postRequest({
    String baseUrl = RestaurantConstants.baseUrl,
    Map<String, String>? optionalHeaders,
    Map<String, dynamic>? data,
    required String path,
    bool showDialog = false,
  });
}

class BaseClientImpl extends BaseClient {
  @override
  Future<Response<dynamic>?> getRequest({
    String baseUrl = RestaurantConstants.baseUrl,
    Map<String, String>? optionalHeaders,
    Map<String, dynamic>? queryParameters,
    required String path,
    bool showDialog = false,
    bool shouldCache = true,
  }) async {
    Response? response;
    if (showDialog) showLoadingDialog();
    debugPrint(baseUrl + path);
    try {
      Map<String, String> header = getHeader();
      if (optionalHeaders != null) {
        header.addAll(optionalHeaders);
      }
      final Dio dio = Dio();
      //ssl certificate bypass
      addCertificate(dio);
      addInterceptors(dio);
      response = await dio.get(
        baseUrl + path,
        queryParameters: queryParameters,
        options: Options(
          headers: header,
          sendTimeout: const Duration(seconds: 40),
          receiveTimeout: const Duration(seconds: 40),
        ),
      );
      if (shouldCache && response.data['status-code'] == 1) {
        locator<SharedPreferences>().setString(
          path,
          jsonEncode(response.data).toString(),
        );
      }
    } on DioException catch (e) {
      if (shouldCache) {
        response = getCachedResponse(path);
      } else {
        response = e.response;
      }
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
      if (shouldCache && e is SocketException) {
        response = getCachedResponse(path);
      }
    }
    if (showDialog) hideLoadingDialog();
    return response;
  }

  @override
  Future<Response?> postRequest({
    String baseUrl = RestaurantConstants.baseUrl,
    Map<String, String>? optionalHeaders,
    Map<String, dynamic>? data,
    required String path,
    bool showDialog = true,
  }) async {
    Response? response;
    if (showDialog) showLoadingDialog();
    try {
      Map<String, String> header = getHeader();
      if (optionalHeaders != null) {
        header.addAll(optionalHeaders);
      }
      final Dio dio = Dio();
      //ssl certificate bypass
      addCertificate(dio);
      addInterceptors(dio);
      response = await dio.post(
        baseUrl + path,
        options: Options(
          headers: header,
          sendTimeout: const Duration(seconds: 40),
          receiveTimeout: const Duration(seconds: 40),
        ),
        data: jsonEncode(data) ,
      );
    } on DioException catch (e) {
      debugPrint(e.toString());
      response = e.response;
    }
    if (showDialog) hideLoadingDialog();
    return response;
  }
}

addCertificate(Dio dio) {
  // ignore: deprecated_member_use
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient dioClient) {
    dioClient.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    return dioClient;
  };
}

addInterceptors(Dio dio) {
  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        error: true,
        requestBody: true,
        requestHeader: false,
        request: true,
        responseBody: true,
      ),
    );
  }
}

Response? getCachedResponse(String endpoint) {
  String? cachedResponse = locator<SharedPreferences>().getString(endpoint);
  Response? response = cachedResponse != null
      ? Response(
          requestOptions: RequestOptions(),
          data: cachedResponse,
          statusCode: 200,
        )
      : null;
  return response;
}
