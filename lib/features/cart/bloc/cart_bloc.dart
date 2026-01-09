import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/functions/extensions.dart';
import 'package:restaurantapp/features/cart/models/cart_item_model.dart';

part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, List<CartItemHolder>> {
  CartBloc() : super([]) {
    on<AddItemToCartEvent>(
      (event, emit) {
        CartItemHolder? cartItem = state.firstWhereOrNull(
          (element) => element.item.itemId == event.cartItem.itemId,
        );
        if (cartItem == null) {
          CartItemHolder item = CartItemHolder(
            item: event.cartItem,
            totalItemCount: 1,
          );
          List<CartItemHolder> items = List.from(state);
          items.add(item);
          emit(items);
        } else {
          List<CartItemHolder> items = List.from(state);
          int index = items.indexOf(cartItem);
          CartItemHolder newItem =
              cartItem.copyWith(totalItemCount: cartItem.totalItemCount + 1);
          items.remove(cartItem);
          items.insert(
            index,
            newItem,
          );
          emit(items);
        }
      },
    );

    on<RemoveItemFromCart>(
      (event, emit) {
        CartItemHolder cartItem = state.firstWhere(
          (element) => element.item.itemId == event.cartItemId,
        );
        List<CartItemHolder> currentItems = List.from(state);
        if (cartItem.totalItemCount == 1) {
          currentItems.removeWhere(
            (element) => element.item.itemId == event.cartItemId,
          );
          emit(currentItems);
        } else {
          CartItemHolder updatedCartItem = cartItem.copyWith(
            totalItemCount: cartItem.totalItemCount - 1,
          );
          int index = currentItems.indexOf(cartItem);
          currentItems.removeWhere(
            (element) => element.item.itemId == event.cartItemId,
          );
          currentItems.insert(
            index,
            updatedCartItem,
          );
          emit(currentItems);
        }
      },
    );
    on<RemoveWholeItemFromCart>(
      (event, emit) async {
        List<CartItemHolder> currentItems = List.from(state);
        currentItems.removeWhere(
            (element) => element.item.itemId == event.cartItem.itemId);
        emit(currentItems);
      },
    );
    on<ResetCartEvent>((event, emit) async {
      emit([]);
    });
  }
}
