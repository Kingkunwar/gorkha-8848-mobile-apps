class CartItemHolder {
  CartItemModel item;
  int totalItemCount;

  CartItemHolder({
    required this.item,
    required this.totalItemCount,
  });

  CartItemHolder copyWith({
    CartItemModel? item,
    int? totalItemCount,
  }) {
    return CartItemHolder(
      item: item ?? this.item,
      totalItemCount: totalItemCount ?? this.totalItemCount,
    );
  }
}

class CartItemModel {
  String price;
  String title;
  String itemId;
  String categoryId;
  String rate;
  int qty;

  CartItemModel({
    required this.price,
    required this.title,
    required this.itemId,
    required this.categoryId,
    required this.qty,
    required this.rate,
  });
}
