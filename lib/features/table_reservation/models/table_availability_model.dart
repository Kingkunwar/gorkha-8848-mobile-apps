class AvailabilityModel {
  List<TimeSlots>? timeSlots;

  // List<Null>? promotions;
  bool? standardAvailabilityMayRequireCreditCard;

  AvailabilityModel({
    this.timeSlots,
    this.standardAvailabilityMayRequireCreditCard,
  });

  AvailabilityModel.fromJson(Map<String, dynamic> json) {
    if (json['TimeSlots'] != null) {
      timeSlots = <TimeSlots>[];
      json['TimeSlots'].forEach((v) {
        timeSlots!.add(TimeSlots.fromJson(v));
      });
    }
    // if (json['Promotions'] != null) {
    //   promotions = <Null>[];
    //   json['Promotions'].forEach((v) {
    //     promotions!.add(new Null.fromJson(v));
    //   });
    // }
    standardAvailabilityMayRequireCreditCard =
        json['StandardAvailabilityMayRequireCreditCard'];
  }
}

class TimeSlots {
  String? timeSlot;
  bool? isLeaveTimeRequired;
  String? leaveTime;
  int? serviceId;
  bool? hasStandardAvailability;

  // List<Null>? availablePromotions;
  num? standardAvailabilityFeeAmount;

  TimeSlots({
    this.timeSlot,
    this.isLeaveTimeRequired,
    this.leaveTime,
    this.serviceId,
    this.hasStandardAvailability,
    // this.availablePromotions,
    this.standardAvailabilityFeeAmount,
  });

  TimeSlots.fromJson(Map<String, dynamic> json) {
    timeSlot = json['TimeSlot'];
    isLeaveTimeRequired = json['IsLeaveTimeRequired'];
    leaveTime = json['LeaveTime'];
    serviceId = json['ServiceId'];
    hasStandardAvailability = json['HasStandardAvailability'];
    // if (json['AvailablePromotions'] != null) {
    //   availablePromotions = <Null>[];
    //   json['AvailablePromotions'].forEach((v) {
    //     availablePromotions!.add(new Null.fromJson(v));
    //   });
    // }
    standardAvailabilityFeeAmount = json['StandardAvailabilityFeeAmount'];
  }
}
