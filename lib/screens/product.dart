class Product {
  final String id;
  final String name;
  final double price;
  final String desc;
  final int quantity;
  final List<String> imageUrls;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.desc,
    required this.quantity,
    required this.imageUrls,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      desc: json['description'] ?? '',
      quantity: int.tryParse(json['quantity'].toString()) ?? 0,
      imageUrls: json['image_url'] != null
          ? List<String>.from(json['image_url'])
          : [], // Default to an empty list if null
    );
  }
}
