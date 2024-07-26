import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final double price;
  final int quantity;
  final String size;
  final String imageUrl;

  CartItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.size,
    required this.imageUrl,
  });
}

class CartProvider with ChangeNotifier {
  double _totalPrice = 0.0;
  int _itemCount = 0;
  List<CartItem> _items = [];

  double get totalPrice => _totalPrice;
  int get itemCount => _itemCount;
  List<CartItem> get items => _items;

  void addToCart(String name, double price, int quantity, String size, String imageUrl) {
    _items.add(CartItem(name: name, price: price, quantity: quantity, size: size, imageUrl: imageUrl));
    _totalPrice += price * quantity;
    _itemCount += quantity;
    notifyListeners();
  }

  void clearCart() {
    _totalPrice = 0.0;
    _itemCount = 0;
    _items.clear();
    notifyListeners();
  }
}

