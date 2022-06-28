import 'package:flutter/foundation.dart';

import '../models/food.dart';

class CartItem {
  final List<String> id;
  final String title;
  final int quantity;
  final double price;
  final String url;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.url,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String canteenId, String stallId, Food food, int quantity) {
    if (quantity == 0) return;
    if (_items.containsKey(food.id)) {
      _items.update(
        food.id!,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: quantity,
            url: existingCartItem.url),
      );
    } else {
      _items.putIfAbsent(
        food.id!,
        () => CartItem(
          id: [canteenId, stallId, food.id!],
          title: food.title,
          price: food.price,
          quantity: quantity,
          url: food.imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity - 1,
              url: existingCartItem.url));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
