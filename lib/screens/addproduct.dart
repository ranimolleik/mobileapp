import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> addProduct(String name, double price, String desc, File image) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('http://vintageclothes.atwebpages.com/addproducts.php'),
  );
  request.fields['name'] = name;
  request.fields['price'] = price.toString();
  request.fields['desc'] = desc;
  request.files.add(
    await http.MultipartFile.fromPath(
      'image',
      image.path,
    ),
  );

  var response = await request.send();
  if (response.statusCode == 200) {
    var responseData = await response.stream.bytesToString();
    var jsonResponse = json.decode(responseData);
    if (jsonResponse['status'] == 'success') {
      print('Product added: ${jsonResponse['url']}');
    } else {
      print('Failed to add product: ${jsonResponse['message']}');
    }
  } else {
    print('Server error: ${response.statusCode}');
  }
}
