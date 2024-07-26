import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'product_list.dart';
import 'cartscreen.dart';
import 'package:provider/provider.dart';
import 'cartprovider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;


  const ProductDetailScreen({required this.product});


  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  String _selectedSize = 'S';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: Color(0xFF708238),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to cart screen or show cart details
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(cart.itemCount.toString()),
                ),
              );
            },
          ),
          SizedBox(width: 10), // Add spacing if needed
        ],

      ),
      body: Stack(
          children: [
          Container(
          color: Color(0xFFFAEBD7), // Background color applied to the entire screen
    ),
       SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         CarouselSlider(
            options: CarouselOptions(
          height: 400.0,
         enlargeCenterPage: true,
          enableInfiniteScroll: false,
         initialPage: 0,
    ),
       items: widget.product.imageUrls.map((fileName) {
          return Builder(
        builder: (BuildContext context) {
        return Image.asset(
        'assets/products/$fileName',
       fit: BoxFit.cover,
    width: double.infinity,
    errorBuilder: (context, error, stackTrace) {
    return Center(child: Text('Failed to load image'));
    },
    );
    },
    );
    }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                widget.product.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '\$${widget.product.price}',
                style: TextStyle(fontSize: 20, color: Colors.grey[700],fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                widget.product.desc,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Quantity',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)
                  ),
                  DropdownButton<int>(
                    value: _quantity,
                    onChanged: (int? newValue) {
                      setState(() {
                        _quantity = newValue!;
                      });
                    },
                    items: List.generate(10, (index) => index + 1)
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Size',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: _selectedSize,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedSize = newValue!;
                      });
                    },
                    items: ['S', 'M', 'L', 'XL']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 20),
         Center(
           child: ElevatedButton(
             onPressed: () {
               final cart = Provider.of<CartProvider>(context, listen: false);
               cart.addToCart(widget.product.name, widget.product.price, _quantity, _selectedSize, widget.product.imageUrls[0]);
               ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text('Added to cart: ${widget.product.name}')),
               );
             },
             style: ElevatedButton.styleFrom(
               backgroundColor: Color(0xFF708238),
               padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
               textStyle: TextStyle(fontSize: 20),
             ),
             child: Text('Add to Cart', style: TextStyle(color: Colors.white)),
           ),
         ),
            ],
          ),
        ),
    ],
      ),
    );
  }
}
