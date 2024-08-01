import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert' as convert;
String _baseURL='vintageclothes.atwebpages.com';

class CartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String size;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.size,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'size': size,
      'imageUrl': imageUrl,
    };
  }
}

class CartProvider with ChangeNotifier {
  double _totalPrice = 0.0;
  int _itemCount = 0;
  List<CartItem> _items = [];

  double get totalPrice => _totalPrice;

  int get itemCount => _itemCount;

  List<CartItem> get items => _items;

  void addToCart(CartItem item) {
    _items.add(item);
    _totalPrice += item.price * item.quantity;
    _itemCount += item.quantity;
    notifyListeners();
  }

  void clearCart() {
    _totalPrice = 0.0;
    _itemCount = 0;
    _items.clear();
    notifyListeners();
  }

  Future<void> fetchCartItems(String userId) async {
    final url = Uri.parse(
        'http://vintageclothes.atwebpages.com/getcartItems.php'); // Your API endpoint
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': userId}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      _items = data.map((item) =>
          CartItem(
            id: item['id'],
            name: item['name'],
            price: item['price'].toDouble(),
            quantity: item['quantity'],
            size: item['size'],
            imageUrl: item['imageUrl'],
          )).toList();
      _totalPrice =
          _items.fold(0.0, (sum, item) => sum + item.price * item.quantity);
      _itemCount = _items.fold(0, (count, item) => count + item.quantity);
      notifyListeners();
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  void addTocart(Function(String text) update, int productId, int userId,
      int quantity, String size) async {
    try {
      final url = Uri.http(_baseURL, '/addtocart.php');
      final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(<String, dynamic>{
            'productId': productId,
            'userId': userId,
            'quantity': quantity,
            'size': size,
          })).timeout(const Duration(seconds: 5));
      update(response.body);
    } catch (e) {
      update("connection error");
    }
  }
}
