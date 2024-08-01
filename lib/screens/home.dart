import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'auth.dart';
import 'product_list.dart';
import 'signup.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final List<String> imgList = [
  'assets/image1.jpg',
  'assets/image2.jpg',
  'assets/image3.jpg',
  'assets/image4.jpg',
  'assets/image5.jpg',
];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF708238),
        actions: authProvider.isLoggedIn
            ? [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authProvider.logout();
            },
          ),
        ]
            : [],
      ),
      body: Container(
        color: const Color(0xFFFAEBD7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                height: 300,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2,
                onPageChanged: (index, reason) {},
              ),
              items: imgList
                  .map((item) => Container(
                child: Center(
                    child: Image.asset(item,
                        fit: BoxFit.cover, width: 1000)),
              ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Vintage it',
              style: TextStyle(fontSize: 24, color: Color(0xFF708238)),
            ),
            const SizedBox(height: 20),
            if (authProvider.isLoggedIn) ...[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProductListScreen()),
                  );
                },
                child: const Text(
                  'Shop Now',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF708238),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
              ),
              const SizedBox(height: 20),
            ],
            if (!authProvider.isLoggedIn)
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                icon: Icon(Icons.person_add, color: Color(0xFF708238)), // Add an icon
                label: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF708238),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Background color
                  overlayColor: Color(0xFF708238), // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: BorderSide(color: Color(0xFF708238), width: 2), // Border color and width
                  elevation: 5, // Shadow effect
                ),
              ),
          ],
        ),
      ),
    );
  }
}
