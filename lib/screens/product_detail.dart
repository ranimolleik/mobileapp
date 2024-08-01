import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'cartprovider.dart';
import 'auth.dart';
import 'product.dart';
import 'cartscreen.dart';
import 'signup.dart';
import 'login.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  String _selectedSize = 'S';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: Color(0xFF708238),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
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
          SizedBox(width: 10),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Color(0xFFFAEBD7),
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
                  items: widget.product.imageUrls.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.network(
                          imageUrl,
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
                  style: TextStyle(fontSize: 20, color: Colors.grey[700], fontWeight: FontWeight.bold),
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
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

    onPressed: () async {
    final cartItem = CartItem(
    id: widget.product.id, // Assuming Product has an id (String)
    name: widget.product.name,
    price: widget.product.price,
    quantity: _quantity,
    size: _selectedSize,
    imageUrl: widget.product.imageUrls.isNotEmpty ? widget.product.imageUrls[0] : '', // Check for empty imageUrls
    );

    // Add to local cart
    cart.addToCart(cartItem);

    // Try to get the user's email
    final userEmail = auth.userEmail; // Nullable String

    if (userEmail != null) {
    try {
    // Print values for debugging
    print('Adding to cart with values: userId=$userEmail, productId=${widget.product.id}, quantity=$_quantity, size=$_selectedSize');

    // Convert product ID from String to int
    final productId = int.tryParse(widget.product.id) ?? 0; // Default to 0 if conversion fails

    // Ensure userId is an int
    final userId = int.tryParse(userEmail) ?? 0; // Default to 0 if conversion fails

    // Call addTocart with the correct types
    cart.addTocart(
    (responseText) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text(responseText.contains("error")
    ? 'Failed to add to cart: $responseText'
        : 'Added to cart: ${widget.product.name}'),
    backgroundColor: responseText.contains("error") ? Colors.red : Colors.green,
    ),
    );
    },
    productId, // Now an int
    userId,    // Now an int
    _quantity, // Should be an int
    _selectedSize // Should be a String
    );
    } catch (e) {
    // Handle any unexpected errors
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text('Failed to add to cart. Please try again.'),
    backgroundColor: Colors.red,
    ),
    );
    print('Error: $e');
    }
    } else {
    // Handle case where user email is not available
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text('User email is not available. Please log in.'),
    backgroundColor: Colors.red,
    ),
    );
    }
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

  void _showAuthOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Please sign up or log in to continue',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF708238),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Log In'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF708238),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
