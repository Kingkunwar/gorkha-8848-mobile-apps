class SuccessPostalCodeModel {
  String? miles;
  String? message;
  String? deliveryCharge;

  SuccessPostalCodeModel({
    this.miles,
    this.message,
    this.deliveryCharge,
  });

  SuccessPostalCodeModel.fromJson(Map<String, dynamic> json) {
    miles = json['miles']?.toString();
    message = json['message']?.toString();
    deliveryCharge = json['delivery_charge']?.toString();
  }
}
