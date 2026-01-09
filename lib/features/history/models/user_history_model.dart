class UserHistoryModel {
  User? user;
  List<Orderhistory>? orderhistory;

  UserHistoryModel({this.user, this.orderhistory});

  UserHistoryModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['orderhistory'] != null) {
      orderhistory = <Orderhistory>[];
      json['orderhistory'].forEach((v) {
        orderhistory!.add(Orderhistory.fromJson(v));
      });
    }
  }
}

class User {
  num? id;
  num? groups;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.groups,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groups = json['groups'];
    name = json['name'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Orderhistory {
  num? id;
  num? orderId;
  num? userId;
  String? orderType;
  String? paymentMethod;
  String? deliveryDateTime;
  String? orderDateTime;
  // Null? discountAmount;
  // Null? discountRate;
  num? deliveryCharge;
  num? paid;
  String? firstName;
  String? lastName;
  String? address;
  String? postalCode;
  String? phone;
  String? email;
  num? status;
  String? createdAt;
  String? updatedAt;
  String? noteForRestaurant;
  String? subTotal;
  String? total;
  List<Items>? items;

  Orderhistory(
      {this.id,
      this.orderId,
      this.userId,
      this.orderType,
      this.paymentMethod,
      this.deliveryDateTime,
      this.orderDateTime,
      // this.discountAmount,
      // this.discountRate,
      this.deliveryCharge,
      this.paid,
      this.firstName,
      this.lastName,
      this.address,
      this.postalCode,
      this.phone,
      this.email,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.noteForRestaurant,
      this.subTotal,
      this.total,
      this.items});

  Orderhistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    orderType = json['order_type'];
    paymentMethod = json['payment_method'];
    deliveryDateTime = json['delivery_date_time'];
    orderDateTime = json['order_date_time'];
    // discountAmount = json['discount_amount'];
    // discountRate = json['discount_rate'];
    deliveryCharge = json['delivery_charge'];
    paid = json['paid'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address = json['address'];
    postalCode = json['postal_code'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    noteForRestaurant = json['note_for_restaurant'];
    subTotal = json['sub_total'];
    total = json['total'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }
}

class Items {
  num? id;
  num? orderId;
  String? item;
  num? price;
  num? qty;
  String? toppings;
  // Null? toppingCharge;
  num? total;
  String? createdAt;
  String? updatedAt;
  // Null? itemId;

  Items({
    this.id,
    this.orderId,
    this.item,
    this.price,
    this.qty,
    this.toppings,
    // this.toppingCharge,
    this.total,
    this.createdAt,
    this.updatedAt,
    // this.itemId,
  });

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    item = json['item'];
    price = json['price'];
    qty = json['qty'];
    toppings = json['toppings'];
    // toppingCharge = json['topping_charge'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // itemId = json['item_id'];
  }
}
