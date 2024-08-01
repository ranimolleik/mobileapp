import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cartprovider.dart';
import 'auth.dart'; // Ensure you import AuthProvider

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final auth = Provider.of<AuthProvider>(context); // Get AuthProvider

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Color(0xFF708238),
        actions: [
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              cart.clearCart();
            },
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFFAEBD7),
        child: cart.items.isEmpty
            ? Center(
          child: Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
            : ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (context, index) {
            final item = cart.items[index];
            return ListTile(
              leading: Image.network(
                item.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(item.name),
              subtitle: Text('Quantity: ${item.quantity}, Size: ${item.size}'),
              trailing: Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
            );
          },
        ),
      ),
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Total Price: \$${cart.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final userEmail = auth.userEmail;

                if (userEmail != null) {
                  try {
                    // Fetch cart items based on the user email
                    await cart.fetchCartItems(userEmail);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Cart items saved successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to save cart items. Please try again.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    print('Error: $e');
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('User email is not available. Please log in.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Checkout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF708238),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
