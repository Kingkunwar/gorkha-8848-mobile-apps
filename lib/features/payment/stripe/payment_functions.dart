import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:restaurantapp/core/constants/app_constants.dart';
import 'package:restaurantapp/core/constants/restaurant_constants.dart';
import 'package:restaurantapp/core/network/client/base_client.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StripeApi {
  createPaymentIntent(
    String amount,
  ) async {
    String userEmail =
        locator<SharedPreferences>().getString(AppConstants.userEmail) ?? '';
    try {
      final response = await locator<BaseClient>().postRequest(
        path: "/payment-intent",
        data: {
          "amount": (num.parse(amount) * 100).toStringAsFixed(0),
          "currency": "GBP",
          "user_email": userEmail,
        },
      );
      // String token = dotenv.get("STRIPE_SECRET");
      // final response = await Dio().post(
      //   "https://api.stripe.com/v1/payment_intents",
      //   options: Options(
      //     headers: {
      //       "Content-Type": "application/x-www-form-urlencoded",
      //       "Authorization": "Bearer $token"
      //     },
      //   ),
      //   data: {
      //     "amount": (num.parse(amount) * 100).toStringAsFixed(0),
      //     "currency": "GBP",
      //     "description": userEmail,
      //     "receipt_email": userEmail,
      //     // "payment_method_types[]": "card"
      //   },
      // );
      // debugPrint(response.toString());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> initPaymentSheet(String amount) async {
    try {
      var paymentIntent = await createPaymentIntent(amount);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          setupIntentClientSecret: paymentIntent.data['client_secret'],
          // Main params
          merchantDisplayName: RestaurantConstants.name,
          paymentIntentClientSecret: paymentIntent.data['client_secret'],

          // Extra options
          style: ThemeMode.system,
        ),
      );

      return displayPaymentSheet(
        navigatorKey.currentContext!,
        paymentIntent.data['payment_intent_id'],
      );
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  Future<String> displayPaymentSheet(BuildContext context, String pid) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return pid;
    } catch (e) {
      debugPrint("Display payment sheet failed $e");
      return "";
    }
  }
}
