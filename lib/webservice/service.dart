import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../Models/productmodel.dart';
import '../Models/responsemodel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final imageurl = 'http://bootcamp.cyralearnings.com/products/';

//Login

  Future<ResponseModel> login(username, password) async {
    Map<String, dynamic> data = {
      'username': username,
      'password': password,
    };
    log("login data ==" + data.toString());
    final response = await Dio().post(
      "http://bootcamp.cyralearnings.com/ecom.login.php",
      data: data,
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log("user = ${response.data}");
      final Map<String, dynamic> responseData = response.data;
      var userData = responseData;
      return ResponseModel.fromJson(userData);
    } else {
      throw Exception('Faild to load login');
    }
  }

//Get Product
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await Dio()
          .get('http://bootcamp.cyralearnings.com/ecom.view_offerproducts.php');
      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        List<ProductModel> products = [];
        for (var userData in response.data) {
          products.add(ProductModel.fromJson(userData));
        }
        return products;
      } else {
        throw Exception('Failed to load product ......');
      }
    } catch (e) {
      log("error get product == $e");
      return [];
    }
  }

  //registeration

  Future<ResponseModel> registration(
      String name, phone, address, username, password) async {
    Map<String, dynamic> data = {
      'name': name,
      'phone': phone,
      'address': address,
      'username': username,
      'password': password,
    };
    log('Register data ==' + data.toString());

    try {
      final response = await http.post(
        Uri.parse("http://bootcamp.cyralearnings.com/ecom.registration.php"),
        // "http://bootcamp.cyralearnings.com/ecom.registration.php",
        body: data,
      );

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log("user === ${response.body}");
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        return ResponseModel.fromJson(responseData);
      } else {
        throw Exception('Failed to load Registration');
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
