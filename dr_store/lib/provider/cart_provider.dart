import 'package:dr_store/models/cart_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider =
    StateNotifierProvider<CartNotifire, Map<String, CartModels>>((ref) {
  return CartNotifire();
});

class CartNotifire extends StateNotifier<Map<String, CartModels>> {
  CartNotifire() : super({});

  void addProductToCart(
      {required String productName,
      required double productPrice,
      required String categoryName,
      required List imageUrl,
      required int quantity,
      required int instock,
      required String productId,
      required String productSize,
      required int discount,
      required String description}) {
    if (state.containsKey(productId)) {
      state = {
        ...state,
        productId: CartModels(
          productName: state[productId]!.productName,
          productPrice: state[productId]!.productPrice,
          categoryName: state[productId]!.categoryName,
          imageUrl: state[productId]!.imageUrl,
          quantity: state[productId]!.quantity + 1,
          instock: state[productId]!.instock,
          productId: state[productId]!.productId,
          productSize: state[productId]!.productSize,
          discount: state[productId]!.discount,
          description: state[productId]!.description,
        )
      };
    } else {
      state = {
        ...state,
        productId: CartModels(
          productName: productName,
          productPrice: productPrice,
          categoryName: categoryName,
          imageUrl: imageUrl,
          quantity: quantity,
          instock: instock,
          productId: productId,
          productSize: productSize,
          discount: discount,
          description: description,
        )
      };
    }
  }

  // Function to remove product from cart
  void removeItem(String productId) {
    state.remove(productId);

    //notify listeners that state has changed
    state = {
      ...state,
    };
  }

  // function increment cart Item
  void incrementItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity++;
    }

    //notify listeners that state has changed  ..තත්ත්වය වෙනස් වී ඇති බව දැනුම් දෙන්න

    state = {
      ...state,
    };
  }

  //decrement cart item

  void decrementItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity--;
    }

    //notify listeners that state has changed  ..තත්ත්වය වෙනස් වී ඇති බව දැනුම් දෙන්න

    state = {
      ...state,
    };
  }

 // error ekk awoth mek aain karnna

  void clearCartData() {
    state.clear();
    //notify listeners that state has changed  ..තත්ත්වය වෙනස් වී ඇති බව දැනුම් දෙන්න
    state = {
      ...state,
    };
  }

  double calculateTotaalAmount() {
    double totalAmount = 0.0;
    state.forEach((productId, cartItem) {
      totalAmount += cartItem.quantity * cartItem.productPrice;
      totalAmount -=
          (cartItem.discount / 100) * (cartItem.quantity * cartItem.productPrice);
    });
    return totalAmount;
  }


  Map<String, CartModels> get getCartItem => state;
}
