part of 'cart_bloc.dart';

sealed class CartEvent {}

class AddItemToCartEvent extends CartEvent {
  final CartItemModel cartItem;
  AddItemToCartEvent({
    required this.cartItem,
  });
}

class RemoveWholeItemFromCart extends CartEvent {
  final CartItemModel cartItem;
  RemoveWholeItemFromCart({
    required this.cartItem,
  });
}

class RemoveItemFromCart extends CartEvent {
  final String cartItemId;

  RemoveItemFromCart({
    required this.cartItemId,
  });
}

class ResetCartEvent extends CartEvent {}
