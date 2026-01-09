class ReservationSuccessModel {
  Booking? booking;
  String? status;
  String? stripePublishableKey;
  String? stripeAccountId;

  ReservationSuccessModel({
    this.booking,
    this.status,
    this.stripePublishableKey,
    this.stripeAccountId,
  });

  ReservationSuccessModel.fromJson(Map<String, dynamic> json) {
    booking =
        json['Booking'] != null ? Booking.fromJson(json['Booking']) : null;
    status = json['Status'];
    stripePublishableKey = json['StripePublishableKey'];
    stripeAccountId = json['StripeAccountId'];
  }
}

class Booking {
  String? reference;
  String? restaurantName;
  String? visitDate;
  String? visitTime;
  int? partySize;
  String? channelCode;
  String? specialRequests;
  String? ipAddress;
  bool? isLeaveTimeConfirmed;
  ReservationCustomer? customer;
  String? token;
  int? areaId;

  Booking({
    this.reference,
    this.restaurantName,
    this.visitDate,
    this.visitTime,
    this.partySize,
    this.channelCode,
    this.specialRequests,
    this.ipAddress,
    this.isLeaveTimeConfirmed,
    this.customer,
    this.token,
    this.areaId,
  });

  Booking.fromJson(Map<String, dynamic> json) {
    reference = json['Reference'];
    restaurantName = json['RestaurantName'];
    visitDate = json['VisitDate'];
    visitTime = json['VisitTime'];
    partySize = json['PartySize'];
    channelCode = json['ChannelCode'];
    specialRequests = json['SpecialRequests'];
    ipAddress = json['IpAddress'];
    isLeaveTimeConfirmed = json['IsLeaveTimeConfirmed'];
    customer = json['Customer'] != null
        ? ReservationCustomer.fromJson(json['Customer'])
        : null;
    token = json['Token'];

    areaId = json['AreaId'];
  }
}

class ReservationCustomer {
  String? title;
  String? firstName;
  String? surname;
  int? mobileCountryCode;
  String? mobile;
  String? email;
  bool? receiveEmailMarketing;
  bool? receiveSmsMarketing;
  bool? receiveResDiaryEmailMarketing;
  bool? receiveResDiarySmsMarketing;
  String? membershipId;
  bool? isFavourite;
  String? company;
  String? phone;
  int? phoneCountryCode;
  String? fullName;
  String? postcode;
  String? groupEmailMarketingOptInText;
  String? groupSmsMarketingOptInText;
  bool? receiveRestaurantEmailMarketing;
  bool? receiveRestaurantSmsMarketing;
  String? restaurantEmailMarketingOptInText;

  ReservationCustomer({
    this.title,
    this.firstName,
    this.surname,
    this.mobileCountryCode,
    this.mobile,
    this.email,
    this.receiveEmailMarketing,
    this.receiveSmsMarketing,
    this.receiveResDiaryEmailMarketing,
    this.receiveResDiarySmsMarketing,
    this.membershipId,
    this.isFavourite,
    this.company,
    this.phone,
    this.phoneCountryCode,
    this.fullName,
    this.postcode,
    this.groupEmailMarketingOptInText,
    this.groupSmsMarketingOptInText,
    this.receiveRestaurantEmailMarketing,
    this.receiveRestaurantSmsMarketing,
    this.restaurantEmailMarketingOptInText,
  });

  ReservationCustomer.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    firstName = json['FirstName'];
    surname = json['Surname'];
    mobileCountryCode = json['MobileCountryCode'];
    mobile = json['Mobile'];
    email = json['Email'];
    receiveEmailMarketing = json['ReceiveEmailMarketing'];
    receiveSmsMarketing = json['ReceiveSmsMarketing'];
    receiveResDiaryEmailMarketing = json['ReceiveResDiaryEmailMarketing'];
    receiveResDiarySmsMarketing = json['ReceiveResDiarySmsMarketing'];
    membershipId = json['MembershipId'];
    isFavourite = json['IsFavourite'];
    company = json['Company'];
    phone = json['Phone'];
    phoneCountryCode = json['PhoneCountryCode'];
    fullName = json['FullName'];
    postcode = json['Postcode'];
    groupEmailMarketingOptInText = json['GroupEmailMarketingOptInText'];
    groupSmsMarketingOptInText = json['GroupSmsMarketingOptInText'];
    receiveRestaurantEmailMarketing = json['ReceiveRestaurantEmailMarketing'];
    receiveRestaurantSmsMarketing = json['ReceiveRestaurantSmsMarketing'];
    restaurantEmailMarketingOptInText =
        json['RestaurantEmailMarketingOptInText'];
  }
}
