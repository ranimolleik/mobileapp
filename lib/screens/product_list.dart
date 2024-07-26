import 'package:flutter/material.dart';
import 'product_card.dart';
import 'cartscreen.dart';

class Product {
  final String name;
  final double price;
  final String desc;
  final List<String> imageUrls;

  Product({required this.name, required this.price,required this.desc, required this.imageUrls});
}

class ProductListScreen extends StatelessWidget {

  final List<Product> products = [
    Product(name: 'Blue Heart Dress', price: 50,desc:
        'A charming and elegant addition to your wardrobe, the Blue Heart Dress features '
            'a delicate heart pattern and a flattering silhouette. Perfect for any occasion,'
            ' this dress combines comfort with style to make you stand out effortlessly.',
        imageUrls: [
      'heart1.jpg',
      'heart2.jpg',
      'heart3.jpg',
    ]),
    Product(name: 'Red and Black dress', price: 60,desc: 'Elevate your wardrobe with this stunning red and black dress.'
        ' Perfect for any occasion this dress combines elegance and style with its '
        'bold color contrast and flattering silhouette.',
        imageUrls: [
      'red1.jpg',
      'red2.jpg',

    ]),
    Product(name: 'Vintage Corset Jumper Dress', price: 40,desc: 'Embrace timeless elegance with our Vintage Corset Jumper Dress. This classic piece '
        'features a flattering corset-style bodice paired with a graceful, flowing skirt, perfect for any occasion.',
        imageUrls: [
      'grey1.jpg',
      'grey2.jpg',
      'grey3.jpg',
    ]),
    Product(name: 'Black and White Dress', price: 55,desc: 'Elegant and versatile, this Black and White Dress is a must-have addition to your wardrobe. Made from high-quality,'
        ' breathable fabric, it ensures comfort all day long. ',
        imageUrls: [
      'black1.jpg',
      'black2.jpg',
      'black3.jpg',
    ]),
    Product(name: 'Blouse and Skirt Set', price: 30,desc: 'Elevate your style with this chic Blouse and Skirt Set. Perfect for both work and weekend outings, this '
        'set combines a stylish blouse with a matching skirt for a coordinated look.',
        imageUrls: [
      'pink1.jpg',
      'pink2.jpg',
      'pink3.jpg',
    ]),
    Product(name: 'Vintage Classic Pink Dress Set', price: 60,desc: 'Embrace timeless elegance with the Vintage Classic Pink Dress Set. This charming set features a beautifully tailored dress with a vintage-inspired silhouette, '
        'complete with delicate pink hues that add a touch of romance. ',
        imageUrls: [
      'pinkw1.jpg',
      'pinkw2.jpg',
      'pinkw3.jpg',
    ]),
    Product(name: 'The Nine Colored Purple Dress Set', price: 66,desc: 'Step into a world of vibrant elegance with The Nine Colored Purple Dress Set. This stunning ensemble features a rich purple dress adorned '
        'with nine distinct shades of purple, creating a captivating gradient effect. ',
        imageUrls: [
      'purple1.jpg',
      'purple2.jpg',
      'purple3.jpg',
    ]),
    Product(name: 'Light Green dress', price: 45,desc: 'A beautiful light green dress, perfect for summer,fits you perfectly',
        imageUrls: [
      'green1.jpg',
      'green2.jpg',
      'green3.jpg',
    ]),
    Product(name: 'Red Skirt, Blouse,and Vest', price:30 ,desc: 'A vibrant red skirt that adds a pop of color '
        'to any outfit. Made from high-quality material for a comfortable fit,it has elegant'
        ' design with a comfortable fit for everyday wear.',
        imageUrls: [
      'red3.jpg',
      'redd2.jpg',
      'redd1.jpg',
    ]),
    Product(name: 'Vintage Classic High Waist Skirt', price: 30,desc: 'Embrace timeless elegance with the Vintage Classic High Waist Skirt. This beautifully tailored skirt features a high waistline'
        ' that accentuates your figure, flowing gracefully to a classic A-line shape. ',
        imageUrls: [
      'classic1.jpg',
      'classic2.jpg',
      'classic3.jpg',
    ]),
    Product(name: 'Purple and White dress', price: 66,desc: 'Stand out in style with the Purple and White Dress, designed to capture attention and showcase elegance. Featuring a striking contrast of purple'
        ' and white, this dress combines vibrant color with a flattering silhouette. ', imageUrls: [
      'purp1.jpg',
      'purp2.jpg',
      'purp3.jpg',
    ]),
    Product(name: 'Vintage Pink Dress', price: 55,desc: 'Embrace timeless elegance with the Vintage Pink Dress. This charming '
        'dress features a classic A-line silhouette with a flattering cinched waist and a knee-length skirt. The soft pink hue and delicate vintage-inspired details create'
        ' a look that’s both romantic and sophisticated.',
        imageUrls: [
      'p2.jpg',
      'p1.jpg',
      'p3.jpg',
    ]),
    Product(name: 'Vintage Green Dress', price: 45,desc: '', imageUrls: [
      'vin1.jpg',
      'vin2.jpg',
      'vin3.jpg',
    ]),
    Product(name: 'Brown Skirt and Vest ', price: 53,desc: 'tep back in time with the Vintage Green Dress, a stunning piece that combines classic style with modern elegance. The dress features a rich'
        ' green hue that enhances its vintage charm, with a fitted bodice and a flared skirt that falls gracefully to the knee.',
        imageUrls: [
      'brown1.jpg',
      'brown2.jpg',
      'brown3.jpg',
    ]),
    Product(name: 'Gothic Black Dress', price: 70,desc: 'Embrace a bold, dramatic look with the Gothic Black Dress. This striking piece features a sleek black fabric with'
        ' intricate lace details and a fitted silhouette that enhances your shape. ',
        imageUrls: [
      'gothic1.jpg',
      'gothic2.jpg',
      'gothic3.jpg',
    ]),
    // Add more products here
  ];

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
