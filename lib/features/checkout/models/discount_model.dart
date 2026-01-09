import 'package:flutter/material.dart';

class DiscountModel {
  num? discountOnDelivery;
  num? discount;

  DiscountModel({
    this.discount,
    this.discountOnDelivery,
  });

  DiscountModel.fromJson(Map<String, dynamic> json) {
    try {
      discount = num.parse(json['discount']);
      discountOnDelivery = num.parse(json['discount_on_delivery']);
    } catch (e) {
      debugPrint("got error on parsing");
    }
  }
}
