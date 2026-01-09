class ReservationModel {
  String? visitDate;
  String? visitTime;
  int? partySize;
  String? channelCode;
  String? specialRequests;
  Customer? customer;
  bool? isLeaveTimeConfirmed;
  String? paymentMethodId;
  String? paymentIntentId;
  String? households;

  ReservationModel({
    this.visitDate,
    this.visitTime,
    this.partySize,
    this.channelCode,
    this.specialRequests,
    this.customer,
    this.isLeaveTimeConfirmed,
    this.paymentMethodId,
    this.paymentIntentId,
    this.households,
  });

  ReservationModel.fromJson(Map<String, dynamic> json) {
    visitDate = json['VisitDate'];
    visitTime = json['VisitTime'];
    partySize = json['PartySize'];
    channelCode = json['ChannelCode'];
    specialRequests = json['SpecialRequests'];
    customer =
        json['Customer'] != null ? Customer.fromJson(json['Customer']) : null;
    isLeaveTimeConfirmed = json['IsLeaveTimeConfirmed'];
    paymentMethodId = json['PaymentMethodId'];
    paymentIntentId = json['PaymentIntentId'];
    households = json['Households'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['VisitDate'] = visitDate;
    data['VisitTime'] = visitTime;
    data['PartySize'] = partySize;
    data['ChannelCode'] = channelCode;
    data['SpecialRequests'] = specialRequests;
    if (customer != null) {
      data['Customer'] = customer!.toJson();
    }
    data['IsLeaveTimeConfirmed'] = isLeaveTimeConfirmed;
    data['PaymentMethodId'] = paymentMethodId;
    data['PaymentIntentId'] = paymentIntentId;
    data['Households'] = households;
    return data;
  }

  ReservationModel copyWith({
    String? visitDate,
    String? visitTime,
    int? partySize,
    String? channelCode,
    String? specialRequests,
    Customer? customer,
    bool? isLeaveTimeConfirmed,
    String? paymentMethodId,
    String? paymentIntentId,
    String? households,
  }) {
    return ReservationModel(
      visitDate: visitDate ?? this.visitDate,
      visitTime: visitTime ?? this.visitTime,
      partySize: partySize ?? this.partySize,
      channelCode: channelCode ?? this.channelCode,
      specialRequests: specialRequests ?? this.specialRequests,
      customer: customer ?? this.customer,
      isLeaveTimeConfirmed: isLeaveTimeConfirmed ?? this.isLeaveTimeConfirmed,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      paymentIntentId: paymentIntentId ?? this.paymentIntentId,
      households: households ?? this.households,
    );
  }
}

class Customer {
  String? firstName;
  String? surname;
  String? mobile;
  String? email;
  bool? receiveEmailMarketing;
  bool? receiveSmsMarketing;
  bool? receiveResDiaryEmailMarketing;
  bool? receiveResDiarySmsMarketing;
  bool? receiveRestaurantEmailMarketing;
  bool? receiveRestaurantSmsMarketing;
  String? groupEmailMarketingOptInText;
  String? groupSmsMarketingOptInText;
  String? restaurantEmailMarketingOptInText;
  String? restaurantSmsMarketingOptInText;
  String? phoneCountryCode;
  String? mobileCountryCode;

  Customer({
    this.firstName,
    this.surname,
    this.mobile,
    this.email,
    this.receiveEmailMarketing,
    this.receiveSmsMarketing,
    this.receiveResDiaryEmailMarketing,
    this.receiveResDiarySmsMarketing,
    this.receiveRestaurantEmailMarketing,
    this.receiveRestaurantSmsMarketing,
    this.groupEmailMarketingOptInText,
    this.groupSmsMarketingOptInText,
    this.restaurantEmailMarketingOptInText,
    this.restaurantSmsMarketingOptInText,
    this.phoneCountryCode,
    this.mobileCountryCode,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    firstName = json['FirstName'];
    surname = json['Surname'];
    mobile = json['Mobile'];
    email = json['Email'];
    receiveEmailMarketing = json['ReceiveEmailMarketing'];
    receiveSmsMarketing = json['ReceiveSmsMarketing'];
    receiveResDiaryEmailMarketing = json['ReceiveResDiaryEmailMarketing'];
    receiveResDiarySmsMarketing = json['ReceiveResDiarySmsMarketing'];
    receiveRestaurantEmailMarketing = json['ReceiveRestaurantEmailMarketing'];
    receiveRestaurantSmsMarketing = json['ReceiveRestaurantSmsMarketing'];
    groupEmailMarketingOptInText = json['GroupEmailMarketingOptInText'];
    groupSmsMarketingOptInText = json['GroupSmsMarketingOptInText'];
    restaurantEmailMarketingOptInText =
        json['RestaurantEmailMarketingOptInText'];
    restaurantSmsMarketingOptInText = json['RestaurantSmsMarketingOptInText'];
    phoneCountryCode = json['PhoneCountryCode'];
    mobileCountryCode = json['MobileCountryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['FirstName'] = firstName;
    data['Surname'] = surname;
    data['Mobile'] = mobile;
    data['Email'] = email;
    data['ReceiveEmailMarketing'] = receiveEmailMarketing;
    data['ReceiveSmsMarketing'] = receiveSmsMarketing;
    data['ReceiveResDiaryEmailMarketing'] = receiveResDiaryEmailMarketing;
    data['ReceiveResDiarySmsMarketing'] = receiveResDiarySmsMarketing;
    data['ReceiveRestaurantEmailMarketing'] = receiveRestaurantEmailMarketing;
    data['ReceiveRestaurantSmsMarketing'] = receiveRestaurantSmsMarketing;
    data['GroupEmailMarketingOptInText'] = groupEmailMarketingOptInText;
    data['GroupSmsMarketingOptInText'] = groupSmsMarketingOptInText;
    data['RestaurantEmailMarketingOptInText'] =
        restaurantEmailMarketingOptInText;
    data['RestaurantSmsMarketingOptInText'] = restaurantSmsMarketingOptInText;
    data['PhoneCountryCode'] = phoneCountryCode;
    data['MobileCountryCode'] = mobileCountryCode;
    return data;
  }

  Customer copyWith({
    String? firstName,
    String? surname,
    String? mobile,
    String? email,
    bool? receiveEmailMarketing,
    bool? receiveSmsMarketing,
    bool? receiveResDiaryEmailMarketing,
    bool? receiveResDiarySmsMarketing,
    bool? receiveRestaurantEmailMarketing,
    bool? receiveRestaurantSmsMarketing,
    String? groupEmailMarketingOptInText,
    String? groupSmsMarketingOptInText,
    String? restaurantEmailMarketingOptInText,
    String? restaurantSmsMarketingOptInText,
    String? phoneCountryCode,
    String? mobileCountryCode,
  }) {
    return Customer(
      firstName: firstName ?? this.firstName,
      surname: surname ?? this.surname,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      receiveEmailMarketing:
          receiveEmailMarketing ?? this.receiveEmailMarketing,
      receiveSmsMarketing: receiveSmsMarketing ?? this.receiveSmsMarketing,
      receiveResDiaryEmailMarketing:
          receiveResDiaryEmailMarketing ?? this.receiveResDiaryEmailMarketing,
      receiveResDiarySmsMarketing:
          receiveResDiarySmsMarketing ?? this.receiveResDiarySmsMarketing,
      receiveRestaurantEmailMarketing: receiveRestaurantEmailMarketing ??
          this.receiveRestaurantEmailMarketing,
      receiveRestaurantSmsMarketing:
          receiveRestaurantSmsMarketing ?? this.receiveRestaurantSmsMarketing,
      groupEmailMarketingOptInText:
          groupEmailMarketingOptInText ?? this.groupEmailMarketingOptInText,
      groupSmsMarketingOptInText:
          groupSmsMarketingOptInText ?? this.groupSmsMarketingOptInText,
      restaurantEmailMarketingOptInText: restaurantEmailMarketingOptInText ??
          this.restaurantEmailMarketingOptInText,
      restaurantSmsMarketingOptInText: restaurantSmsMarketingOptInText ??
          this.restaurantSmsMarketingOptInText,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      mobileCountryCode: mobileCountryCode ?? this.mobileCountryCode,
    );
  }
}
