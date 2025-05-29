import 'package:dr_store/models/favorite_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, Map<String, FavoriteModel>>(
    (ref) {
  return FavoriteNotifier();
});

class FavoriteNotifier extends StateNotifier<Map<String, FavoriteModel>> {
  FavoriteNotifier() : super({});

  void addProductToFavorite({
    required String productName,
    required String productId,
    required List imageUrl,
    required int productPrice,
  }) {
    state[productId] = FavoriteModel(
        productName: productName,
        productId: productId,
        imageUrl: imageUrl,
        productPrice: productPrice);

        state = {...state};
  }

  //remove all items from favorite
  void removeAllItems() {
    state.clear();

    state = {...state};
  }

  //remove favorite item
  void removeItem(String productId) {
    state.remove(productId);

    state = {...state};
  }

  // retrve value from the favourite
  Map<String, FavoriteModel> get getFavoriteItem => state;
}
