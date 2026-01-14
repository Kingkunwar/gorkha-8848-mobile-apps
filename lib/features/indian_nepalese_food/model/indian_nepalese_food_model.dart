class IndianNepaleseFoodModel {
  List<ItemModel>? foodItems;
  IndianNepaleseFoodModel({
    this.foodItems,
  });

  IndianNepaleseFoodModel.fromJson(Map<String, dynamic> json) {
    foodItems = [];
    if (json.values.isNotEmpty) {
      for (var element in json.values) {
        foodItems!.add(ItemModel.fromJson(element));
      }
    }
  }
}

class ItemModel {
  String? title;
  String? details;
  int? id;
  int? orderBy;
  SubItemModel? items;

  ItemModel({this.title, this.details, this.id, this.orderBy, this.items});

  ItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    details = json['details'];
    id = json['id'];
    orderBy = json['order_by'];
    items = json['items'] != null ? SubItemModel.fromJson(json['items']) : null;
  }
}

class SubItemModel {
  List<SubItem>? subItems;

  SubItemModel({this.subItems});

  SubItemModel.fromJson(Map<String, dynamic> json) {
    subItems = [];
    if (json.keys.isNotEmpty) {
      for (var value in json.values) {
        subItems!.add(SubItem.fromJson(value));
      }
    }
  }
}

class SubItem {
  int? id;
  int? categoryId;
  String? title;
  String? slug;
  String? price;
  // Null? tablePrice;
  // Null? image;
  String? details;
  int? status;
  int? setmeal;
  int? hotLevel;
  List<String>? allergyAdvice;
  // Null? topping;
  int? orderBy;
  String? createdAt;
  String? updatedAt;
  // Null? popularDish;
  int? printAll;
  int? printIgnore;
  List<SubPrices>? prices;
  String? imageUrl;

  SubItem({
    this.id,
    this.categoryId,
    this.title,
    this.slug,
    this.price,
    // this.tablePrice,
    // this.image,
    this.details,
    this.status,
    this.setmeal,
    this.hotLevel,
    this.allergyAdvice,
    // this.topping,
    this.orderBy,
    this.createdAt,
    this.updatedAt,
    // this.popularDish,
    this.printAll,
    this.printIgnore,
    this.prices,
    this.imageUrl,
  });

  SubItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price']?.toString();
    // tablePrice = json['table_price'];
    // image = json['image'];
    details = json['details'];
    status = json['status'];
    setmeal = json['setmeal'];
    hotLevel = json['hot_level'];
    allergyAdvice = json['allergy_advice']?.cast<String>();
    // topping = json['topping'];
    orderBy = json['order_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // popularDish = json['popular_dish'];
    printAll = json['print_all'];
    printIgnore = json['print_ignore'];
    if (json['prices'] != null) {
      prices = <SubPrices>[];
      json['prices'].forEach((v) {
        prices!.add(SubPrices.fromJson(v));
      });
    }
    imageUrl = json['image_url'];
  }
}

class SubPrices {
  int? id;
  int? itemId;
  String? title;
  String? price;
  String? createdAt;
  String? updatedAt;

  SubPrices({
    this.id,
    this.itemId,
    this.createdAt,
    this.price,
    this.title,
    this.updatedAt,
  });

  SubPrices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    title = json['title'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Prices {
  int? id;
  int? itemId;
  String? title;
  String? price;
  String? createdAt;
  String? updatedAt;

  Prices(
      {this.id,
      this.itemId,
      this.title,
      this.price,
      this.createdAt,
      this.updatedAt});

  Prices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    title = json['title'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
