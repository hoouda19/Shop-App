import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get item {
    return {..._items};
  }

  double get getQuantity {
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  int get cartCount {
    return _items.length;
  }

  void deleteItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void addItem(String poductId, double price, String title) {
    if (_items.containsKey(poductId)) {
      _items.update(
          poductId,
          (val) => CartItem(
              id: val.id,
              title: val.title,
              price: val.price,
              quantity: val.quantity + 1));
    } else {
      _items.putIfAbsent(
          poductId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void clearItem() {
    _items = {};
    notifyListeners();
  }
}
