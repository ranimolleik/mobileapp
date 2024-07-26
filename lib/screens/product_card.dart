import 'package:flutter/material.dart';
import 'product_detail.dart';
import 'product_list.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.2,
                child: Image.asset(
                  'assets/products/${product.imageUrls.isNotEmpty ? product.imageUrls[0] : 'placeholder.jpg'}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print('Failed to load image: assets/products/${product.imageUrls.isNotEmpty ? product.imageUrls[0] : 'placeholder.jpg'}');
                    return Center(child: Text('Image not available'));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '\$${product.price}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
