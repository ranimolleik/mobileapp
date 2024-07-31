import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product_card.dart';
import 'cartscreen.dart';
import 'product.dart';
import 'admin_page.dart';

const String _baseURL = 'vintageclothes.atwebpages.com';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<void> getProducts() async {
    try {
      final url = Uri.http(_baseURL, '/getproducts.php');
      final response = await http.get(url).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final responseBody = response.body;
        print('Response body: $responseBody'); // Print the response body
        final List<dynamic> productJson = json.decode(responseBody);
        setState(() {
          products = productJson.map((json) => Product.fromJson(json)).toList();
          isLoading = false;
        });
        for (var product in products) {
          print('Product: ${product.name}, Image URL: ${product.imageUrls}');
        }
      } else {
        showErrorSnackBar('Failed to load products: ${response.statusCode}');
      }
    } catch (error) {
      showErrorSnackBar('Failed to load products: $error');
    }
  }


  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    setState(() {
      isLoading = false;
    });
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()), // Ensure CartScreen is defined
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminPage()),
              );
              if (result == true) {
                getProducts(); // Refresh the product list if a product was added
              }
            },
          ),
          SizedBox(width: 10),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
        color: Color(0xFFFAEBD7),
        child: RefreshIndicator(
          onRefresh: getProducts,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(product: product);
            },
          ),
        ),
      ),
    );
  }
}
