class LastOrderDetailsModel {
  String? firstName;
  String? lastName;
  String? address;
  String? phone;

  LastOrderDetailsModel(
      {this.firstName, this.lastName, this.address, this.phone});

  LastOrderDetailsModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    address = json['address'];
    phone = json['phone'];
  }
}
