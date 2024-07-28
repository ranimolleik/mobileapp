import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product_card.dart';
import 'cartscreen.dart';

String _baseURL='vintageclothes.atwebpages.com';

class Product {
  final String name;
  final double price;
  final String desc;
  final List<String> imageUrls;

  Product({required this.name, required this.price, required this.desc, required this.imageUrls});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: double.parse(json['price']),
      desc: json['desc'],
      imageUrls: List<String>.from(json['imageUrls']),
    );
  }
} 
class ProductDetailScreen extends StatefulWidget {

  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getProducts();
  }
  void getProducts()async{
    final url = Uri.http(_baseURL, '/getproducts.php');
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5)); // max timeout 5 seconds
    products.clear(); // clear old products
    if (response.statusCode == 200) {
      final List<dynamic> productJson = json.decode(response.body);
      setState(() {
        products = productJson.map((json) => Product.fromJson(json)).toList();
        isLoading = false;
      });
      }
      // if successful call

     else {
      // Handle the error
      throw Exception('Failed to load products');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product List',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF708238),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to cart screen or show cart details
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()), // Ensure CartScreen is defined
              );
            },
          ),
          SizedBox(width: 10), // Add spacing if needed
        ],
      ),
      body: Container(
        color: Color(0xFFFAEBD7),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two items per row
            crossAxisSpacing: 8.0, // Spacing between columns
            mainAxisSpacing: 8.0,  // Spacing between rows
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(product: product);
          },
        ),
      ),
    );
  }
}





