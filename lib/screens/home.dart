import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ranim_flutter/screens/login.dart';
import 'package:ranim_flutter/screens/product_list.dart';
import 'package:ranim_flutter/screens/signup.dart';

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
        backgroundColor: Color(0xFF708238),
      ),
      body: Container(
        color: Color(0xFFFAEBD7), // Set the background color of the body to light grey
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                height: 300,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2,
                onPageChanged: (index, reason) {
                  // Handle page change if needed
                },
              ),
              items: imgList.map((item) => Container(
                child: Center(
                    child: Image.asset(item, fit: BoxFit.cover, width: 1000)
                ),
              )).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Vintage it',
              style: TextStyle(fontSize: 24, color: Color(0xFF708238)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProductListScreen()),
                );
              },
              child: const Text(
                'Shop Now',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF708238), // Background color
                overlayColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Button padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                elevation: 5, // Shadow effect
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignUpPage()), // Replace with your actual SignUp screen
                    );
                  },
                  child: const Text('Sign Up', style: TextStyle(fontSize: 16, color: Color(0xFF708238))),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Background color
                    overlayColor: Color(0xFF708238), // Text color
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    side: BorderSide(color: Color(0xFF708238), width: 1), // Border color and width
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
