import 'package:flutter/material.dart';

class MealDealModel {
  List<MealDealHolder>? mealDealItems;
  MealDealModel({
    this.mealDealItems,
  });

  MealDealModel.fromJson(List<dynamic> json) {
    mealDealItems = [];
    if (json.isNotEmpty) {
      for (var element in json) {
        mealDealItems!.add(
          MealDealHolder.fromJson(
            element,
          ),
        );
      }
    }
  }
}

class MealDealHolder {
  int? id;
  String? title;
  String? price;
  int? status;
  int? orderBy;
  String? details;
  String? createdAt;
  String? updatedAt;
  String? image;
  int? options;
  List<MealDealItems>? mealDealItems;

  MealDealHolder({
    this.id,
    this.title,
    this.price,
    this.status,
    this.orderBy,
    this.details,
    this.options,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.mealDealItems,
  });

  MealDealHolder.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      options = json['options'];
      title = json['title'];
      price = json['price']?.toString();
      status = json['status'];
      orderBy = json['order_by'];
      details = json['details'];
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];
      image = json['image'];
      if (json['meal_deal_items'] != null) {
        mealDealItems = <MealDealItems>[];
        json['meal_deal_items'].forEach(
          (v) {
            mealDealItems!.add(
              MealDealItems.fromJson(v),
            );
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

class MealDealItems {
  int? id;
  int? mealDealId;
  int? options;
  String? title;
  String? price;
  String? item;
  int? categoryId;
  int? isMultiple;
  int? isPriced;
  int? chooseUpTo;
  String? createdAt;
  String? updatedAt;
  Category? category;

  MealDealItems({
    this.id,
    this.mealDealId,
    this.options,
    this.price,
    this.title,
    this.item,
    this.categoryId,
    this.isMultiple,
    this.isPriced,
    this.chooseUpTo,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  MealDealItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mealDealId = json['meal_deal_id'];
    options = json['options'];
    title = json['title'];
    item = json['item'];
    categoryId = json['category_id'];
    isMultiple = json['is_multiple'];
    isPriced = json['is_priced'];
    chooseUpTo = json['choose_up_to'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }
}

class Category {
  int? id;
  int? parentId;
  String? title;
  String? slug;
  // Null? image;
  String? details;
  int? status;
  int? orderBy;
  int? mealdeal;
  int? indiannepalese;
  int? pizzaburger;
  // // Null? metaTitle;
  // Null? metaDescription;
  // Null? metaKeyword;
  String? createdAt;
  String? updatedAt;
  List<Items>? items;

  Category({
    this.id,
    this.parentId,
    this.title,
    this.slug,
    // this.image,
    this.details,
    this.status,
    this.orderBy,
    this.mealdeal,
    this.indiannepalese,
    this.pizzaburger,
    // this.metaTitle,
    // this.metaDescription,
    // this.metaKeyword,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    title = json['title'];
    slug = json['slug'];
    // image = json['image'];
    details = json['details'];
    status = json['status'];
    orderBy = json['order_by'];
    mealdeal = json['mealdeal'];
    indiannepalese = json['indiannepalese'];
    pizzaburger = json['pizzaburger'];
    // metaTitle = json['meta_title'];
    // metaDescription = json['meta_description'];
    // metaKeyword = json['meta_keyword'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }
}

class Items {
  int? id;
  int? categoryId;
  String? title;
  String? slug;
  String? price;
  // Null? tablePrice;
  String? image;
  String? details;
  int? status;
  int? setmeal;
  int? hotLevel;
  List<String>? allergyAdvice;
  int? topping;
  int? orderBy;
  String? createdAt;
  String? updatedAt;
  // Null? popularDish;
  int? printAll;
  int? printIgnore;

  Items({
    this.id,
    this.categoryId,
    this.title,
    this.slug,
    this.price,
    // this.tablePrice,
    this.image,
    this.details,
    this.status,
    this.setmeal,
    this.hotLevel,
    this.allergyAdvice,
    this.topping,
    this.orderBy,
    this.createdAt,
    this.updatedAt,
    // this.popularDish,
    this.printAll,
    this.printIgnore,
  });

  Items.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      categoryId = json['category_id'];
      title = json['title'];
      slug = json['slug'];
      price = json['price']?.toString();
      // tablePrice = json['table_price'];
      image = json['image'];
      details = json['details'];
      status = json['status'];
      setmeal = json['setmeal'];
      hotLevel = json['hot_level'];
      allergyAdvice = json['allergy_advice']?.cast<String>();
      topping = json['topping'];
      orderBy = json['order_by'];
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];
      // popularDish = json['popular_dish'];
      printAll = json['print_all'];
      printIgnore = json['print_ignore'];
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
