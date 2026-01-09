import 'package:flutter/material.dart';
import 'package:restaurantapp/app/functions/extensions.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/checkout/discount_cubit/discount_cubit.dart';

class DeliveryConstants {
  static num minOrderForDelivery = 0;

  static num discountPercentageOnDelivery = 0;
  static num minimumAmountForDiscountDelivery = 0;
  static num minimumAmountForDiscountCollection = 0;

  static num discountPercentageOnCollection = 0;
  static num minimumAmountForCollectionDiscount = 0;
}

class SettingsModel {
  String? storePostalCode;
  String? maxRadiusInMile;
  String? minOrder;
  String? deliveryTimeInterval;
  String? additionalDeliveryCharge;
  String? collectionTimeInterval;
  String? discount;
  String? minDiscountCost;
  String? sundayOpenTime;
  String? sundayCloseTime;
  String? mondayOpenTime;
  String? mondayCloseTime;
  String? tuesdayOpenTime;
  String? tuesdayCloseTime;
  String? wednesdayOpenTime;
  String? wednesdayCloseTime;
  String? thursdayOpenTime;
  String? thursdayCloseTime;
  String? fridayOpenTime;
  String? fridayCloseTime;
  String? saturdayOpenTime;
  String? saturdayCloseTime;
  String? emails;
  String? googleMap;
  String? facebookPage;
  String? storeCloseDay;
  String? discountOnDelivery;
  String? minDiscountCostDelivery;
  String? deliveryCharges;
  String? deliveryEnabled;
  String? collectionEnabled;
  String? tableReservation;
  String? holidayDates;
  String? sundayDeliveryOpenTime;
  String? sundayDeliveryCloseTime;
  String? sundayDeliveryDiscount;
  String? sundayCollectionOpenTime;
  String? sundayCollectionCloseTime;
  String? sundayCollectionDiscount;
  String? mondayDeliveryOpenTime;
  String? mondayDeliveryCloseTime;
  String? mondayDeliveryDiscount;
  String? mondayCollectionOpenTime;
  String? mondayCollectionCloseTime;
  String? mondayCollectionDiscount;
  String? tuesdayDeliveryOpenTime;
  String? tuesdayDeliveryCloseTime;
  String? tuesdayDeliveryDiscount;
  String? tuesdayCollectionOpenTime;
  String? tuesdayCollectionCloseTime;
  String? tuesdayCollectionDiscount;
  String? wednesdayDeliveryOpenTime;
  String? wednesdayDeliveryCloseTime;
  String? wednesdayDeliveryDiscount;
  String? wednesdayCollectionOpenTime;
  String? wednesdayCollectionCloseTime;
  String? wednesdayCollectionDiscount;
  String? thursdayDeliveryOpenTime;
  String? thursdayDeliveryCloseTime;
  String? thursdayDeliveryDiscount;
  String? thursdayCollectionOpenTime;
  String? thursdayCollectionCloseTime;
  String? thursdayCollectionDiscount;
  String? fridayDeliveryOpenTime;
  String? fridayDeliveryCloseTime;
  String? fridayDeliveryDiscount;
  String? fridayCollectionOpenTime;
  String? fridayCollectionCloseTime;
  String? fridayCollectionDiscount;
  String? saturdayDeliveryOpenTime;
  String? saturdayDeliveryCloseTime;
  String? saturdayDeliveryDiscount;
  String? saturdayCollectionOpenTime;
  String? saturdayCollectionCloseTime;
  String? saturdayCollectionDiscount;
  String? christmasEnabled;
  String? tripadvisor;
  String? paymentCod;
  String? paymentStripe;
  String? stripeKey;
  String? stripePkey;
  String? footerType;
  String? giftEnabled;
  String? sundayBreakStartTime;
  String? sundayBreakEndTime;
  String? mondayBreakStartTime;
  String? mondayBreakEndTime;
  String? tuesdayBreakStartTime;
  String? tuesdayBreakEndTime;
  String? wednesdayBreakStartTime;
  String? wednesdayBreakEndTime;
  String? thursdayBreakStartTime;
  String? thursdayBreakEndTime;
  String? fridayBreakStartTime;
  String? fridayBreakEndTime;
  String? saturdayBreakStartTime;
  String? saturdayBreakEndTime;
  String? fbLogin;
  String? ggLogin;
  String? ggClientId;
  String? ggClientSecret;
  String? fbClientId;
  String? fbClientSecret;
  String? menuTitle;
  String? menuEnabled;
  String? christmasMenu;
  // Null? menu;
  String? paymentTrustpay;
  String? trustpayLivestatus;
  String? trustpayReference;
  String? trustpayUser;
  String? trustpaySecret;

  SettingsModel(
      {this.storePostalCode,
      this.maxRadiusInMile,
      this.minOrder,
      this.deliveryTimeInterval,
      this.additionalDeliveryCharge,
      this.collectionTimeInterval,
      this.discount,
      this.minDiscountCost,
      this.sundayOpenTime,
      this.sundayCloseTime,
      this.mondayOpenTime,
      this.mondayCloseTime,
      this.tuesdayOpenTime,
      this.tuesdayCloseTime,
      this.wednesdayOpenTime,
      this.wednesdayCloseTime,
      this.thursdayOpenTime,
      this.thursdayCloseTime,
      this.fridayOpenTime,
      this.fridayCloseTime,
      this.saturdayOpenTime,
      this.saturdayCloseTime,
      this.emails,
      this.googleMap,
      this.facebookPage,
      this.storeCloseDay,
      this.discountOnDelivery,
      this.minDiscountCostDelivery,
      this.deliveryCharges,
      this.deliveryEnabled,
      this.collectionEnabled,
      this.tableReservation,
      this.holidayDates,
      this.sundayDeliveryOpenTime,
      this.sundayDeliveryCloseTime,
      this.sundayDeliveryDiscount,
      this.sundayCollectionOpenTime,
      this.sundayCollectionCloseTime,
      this.sundayCollectionDiscount,
      this.mondayDeliveryOpenTime,
      this.mondayDeliveryCloseTime,
      this.mondayDeliveryDiscount,
      this.mondayCollectionOpenTime,
      this.mondayCollectionCloseTime,
      this.mondayCollectionDiscount,
      this.tuesdayDeliveryOpenTime,
      this.tuesdayDeliveryCloseTime,
      this.tuesdayDeliveryDiscount,
      this.tuesdayCollectionOpenTime,
      this.tuesdayCollectionCloseTime,
      this.tuesdayCollectionDiscount,
      this.wednesdayDeliveryOpenTime,
      this.wednesdayDeliveryCloseTime,
      this.wednesdayDeliveryDiscount,
      this.wednesdayCollectionOpenTime,
      this.wednesdayCollectionCloseTime,
      this.wednesdayCollectionDiscount,
      this.thursdayDeliveryOpenTime,
      this.thursdayDeliveryCloseTime,
      this.thursdayDeliveryDiscount,
      this.thursdayCollectionOpenTime,
      this.thursdayCollectionCloseTime,
      this.thursdayCollectionDiscount,
      this.fridayDeliveryOpenTime,
      this.fridayDeliveryCloseTime,
      this.fridayDeliveryDiscount,
      this.fridayCollectionOpenTime,
      this.fridayCollectionCloseTime,
      this.fridayCollectionDiscount,
      this.saturdayDeliveryOpenTime,
      this.saturdayDeliveryCloseTime,
      this.saturdayDeliveryDiscount,
      this.saturdayCollectionOpenTime,
      this.saturdayCollectionCloseTime,
      this.saturdayCollectionDiscount,
      this.christmasEnabled,
      this.tripadvisor,
      this.paymentCod,
      this.paymentStripe,
      this.stripeKey,
      this.stripePkey,
      this.footerType,
      this.giftEnabled,
      this.sundayBreakStartTime,
      this.sundayBreakEndTime,
      this.mondayBreakStartTime,
      this.mondayBreakEndTime,
      this.tuesdayBreakStartTime,
      this.tuesdayBreakEndTime,
      this.wednesdayBreakStartTime,
      this.wednesdayBreakEndTime,
      this.thursdayBreakStartTime,
      this.thursdayBreakEndTime,
      this.fridayBreakStartTime,
      this.fridayBreakEndTime,
      this.saturdayBreakStartTime,
      this.saturdayBreakEndTime,
      this.fbLogin,
      this.ggLogin,
      this.ggClientId,
      this.ggClientSecret,
      this.fbClientId,
      this.fbClientSecret,
      this.menuTitle,
      this.menuEnabled,
      this.christmasMenu,
      // this.menu,
      this.paymentTrustpay,
      this.trustpayLivestatus,
      this.trustpayReference,
      this.trustpayUser,
      this.trustpaySecret});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    storePostalCode = json['store_postal_code'];
    maxRadiusInMile = json['max_radius_in_mile'];
    minOrder = json['min_order'].toString();
    if (minOrder != null && minOrder!.toLowerCase() != "null") {
      DeliveryConstants.minOrderForDelivery = num.parse(minOrder!);
    }
    deliveryTimeInterval = json['delivery_time_interval'];
    additionalDeliveryCharge = json['additional_delivery_charge'];
    collectionTimeInterval = json['collection_time_interval'];
    discount = json['discount'];
    minDiscountCost = json['min_discount_cost'];
    sundayOpenTime = json['sunday_open_time'];
    sundayCloseTime = json['sunday_close_time'];
    mondayOpenTime = json['monday_open_time'];
    mondayCloseTime = json['monday_close_time'];
    tuesdayOpenTime = json['tuesday_open_time'];
    tuesdayCloseTime = json['tuesday_close_time'];
    wednesdayOpenTime = json['wednesday_open_time'];
    wednesdayCloseTime = json['wednesday_close_time'];
    thursdayOpenTime = json['thursday_open_time'];
    thursdayCloseTime = json['thursday_close_time'];
    fridayOpenTime = json['friday_open_time'];
    fridayCloseTime = json['friday_close_time'];
    saturdayOpenTime = json['saturday_open_time'];
    saturdayCloseTime = json['saturday_close_time'];
    emails = json['emails'];
    googleMap = json['google_map'];
    facebookPage = json['facebook_page'];
    storeCloseDay = json['store_close_day'];
    discountOnDelivery = json['discount_on_delivery'];
    minDiscountCostDelivery = json['min_discount_cost_delivery'];
    deliveryCharges = json['delivery_charges'];
    deliveryEnabled = json['delivery_enabled'];
    collectionEnabled = json['collection_enabled'];
    tableReservation = json['table_reservation'];
    holidayDates = json['holiday_dates'];
    sundayDeliveryOpenTime = json['sunday_delivery_open_time'];
    sundayDeliveryCloseTime = json['sunday_delivery_close_time'];
    sundayDeliveryDiscount = json['sunday_delivery_discount'];
    sundayCollectionOpenTime = json['sunday_collection_open_time'];
    sundayCollectionCloseTime = json['sunday_collection_close_time'];
    sundayCollectionDiscount = json['sunday_collection_discount'];
    mondayDeliveryOpenTime = json['monday_delivery_open_time'];
    mondayDeliveryCloseTime = json['monday_delivery_close_time'];
    mondayDeliveryDiscount = json['monday_delivery_discount'];
    mondayCollectionOpenTime = json['monday_collection_open_time'];
    mondayCollectionCloseTime = json['monday_collection_close_time'];
    mondayCollectionDiscount = json['monday_collection_discount'];
    tuesdayDeliveryOpenTime = json['tuesday_delivery_open_time'];
    tuesdayDeliveryCloseTime = json['tuesday_delivery_close_time'];
    tuesdayDeliveryDiscount = json['tuesday_delivery_discount'];
    tuesdayCollectionOpenTime = json['tuesday_collection_open_time'];
    tuesdayCollectionCloseTime = json['tuesday_collection_close_time'];
    tuesdayCollectionDiscount = json['tuesday_collection_discount'];
    wednesdayDeliveryOpenTime = json['wednesday_delivery_open_time'];
    wednesdayDeliveryCloseTime = json['wednesday_delivery_close_time'];
    wednesdayDeliveryDiscount = json['wednesday_delivery_discount'];
    wednesdayCollectionOpenTime = json['wednesday_collection_open_time'];
    wednesdayCollectionCloseTime = json['wednesday_collection_close_time'];
    wednesdayCollectionDiscount = json['wednesday_collection_discount'];
    thursdayDeliveryOpenTime = json['thursday_delivery_open_time'];
    thursdayDeliveryCloseTime = json['thursday_delivery_close_time'];
    thursdayDeliveryDiscount = json['thursday_delivery_discount'];
    thursdayCollectionOpenTime = json['thursday_collection_open_time'];
    thursdayCollectionCloseTime = json['thursday_collection_close_time'];
    thursdayCollectionDiscount = json['thursday_collection_discount'];
    fridayDeliveryOpenTime = json['friday_delivery_open_time'];
    fridayDeliveryCloseTime = json['friday_delivery_close_time'];
    fridayDeliveryDiscount = json['friday_delivery_discount'];
    fridayCollectionOpenTime = json['friday_collection_open_time'];
    fridayCollectionCloseTime = json['friday_collection_close_time'];
    fridayCollectionDiscount = json['friday_collection_discount'];
    saturdayDeliveryOpenTime = json['saturday_delivery_open_time'];
    saturdayDeliveryCloseTime = json['saturday_delivery_close_time'];
    saturdayDeliveryDiscount = json['saturday_delivery_discount'];
    saturdayCollectionOpenTime = json['saturday_collection_open_time'];
    saturdayCollectionCloseTime = json['saturday_collection_close_time'];
    saturdayCollectionDiscount = json['saturday_collection_discount'];
    christmasEnabled = json['christmas_enabled'];
    tripadvisor = json['tripadvisor'];
    paymentCod = json['payment_cod'];
    paymentStripe = json['payment_stripe'];
    stripeKey = json['stripe_key'];
    stripePkey = json['stripe_pkey'];
    footerType = json['footer_type'];
    giftEnabled = json['gift_enabled'];
    sundayBreakStartTime = json['sunday_break_start_time'];
    sundayBreakEndTime = json['sunday_break_end_time'];
    mondayBreakStartTime = json['monday_break_start_time'];
    mondayBreakEndTime = json['monday_break_end_time'];
    tuesdayBreakStartTime = json['tuesday_break_start_time'];
    tuesdayBreakEndTime = json['tuesday_break_end_time'];
    wednesdayBreakStartTime = json['wednesday_break_start_time'];
    wednesdayBreakEndTime = json['wednesday_break_end_time'];
    thursdayBreakStartTime = json['thursday_break_start_time'];
    thursdayBreakEndTime = json['thursday_break_end_time'];
    fridayBreakStartTime = json['friday_break_start_time'];
    fridayBreakEndTime = json['friday_break_end_time'];
    saturdayBreakStartTime = json['saturday_break_start_time'];
    saturdayBreakEndTime = json['saturday_break_end_time'];

    try {
      num deliveryDiscount =
          num.parse(json["${DateTime.now().dayName()}_delivery_discount"]);
      num collectionDiscount =
          num.parse(json["${DateTime.now().dayName()}_collection_discount"]);
      DeliveryConstants.discountPercentageOnDelivery =
          deliveryDiscount;
      DeliveryConstants.minimumAmountForDiscountDelivery =
          num.tryParse(minDiscountCostDelivery!) ?? 20;
      DeliveryConstants.minimumAmountForDiscountCollection =
          num.tryParse(minDiscountCost!) ?? 20;
      DeliveryConstants.discountPercentageOnCollection = collectionDiscount;
      locator<DiscountCubit>().setDiscount(
        deliveryDiscount,
        collectionDiscount,
      );
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }

    fbLogin = json['fb_login'];
    ggLogin = json['gg_login'];
    ggClientId = json['gg_client_id'];
    ggClientSecret = json['gg_client_secret'];
    fbClientId = json['fb_client_id'];
    fbClientSecret = json['fb_client_secret'];
    menuTitle = json['menu_title'];
    menuEnabled = json['menu_enabled'];
    christmasMenu = json['christmas_menu'];
    // menu = json['m enu'];
    paymentTrustpay = json['payment_trustpay'];
    trustpayLivestatus = json['trustpay_livestatus'];
    trustpayReference = json['trustpay_reference'];
    trustpayUser = json['trustpay_user'];
    trustpaySecret = json['trustpay_secret'];
  }
}
