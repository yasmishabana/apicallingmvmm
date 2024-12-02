import 'dart:developer';

import 'package:flutter/material.dart';

import '../Models/responsemodel.dart';
import '../Viewmodels/productviewmodel.dart';
import '../Viewmodels/responseviewmodel.dart';
import '../webservice/service.dart';

class CommonViewModel extends ChangeNotifier {
  ResponseViewmodel? response;
  List<ProductViewmodel> productslist = [];

  bool _loginload = false;
  bool get loginload => _loginload;

  bool _productload = false;
  bool get productload => _productload;

  bool _registerLoad = false;
  bool get registerLoad => _registerLoad;

  // Login method
  Future<ResponseViewmodel?> login(String username, String password) async {
    _loginload = true;
    notifyListeners(); // Notify listeners that loading has started

    try {
      final results = await ApiService().login(username, password);

      // ignore: unnecessary_null_comparison
      if (results != null) {
        response = ResponseViewmodel(data: results);
        log('Login response ==== ${response!.msg}');
      } else {
        log('Login response is null');
        response = ResponseViewmodel(data: ResponseModel(msg: 'failed'));
        // Default message on null response
      }
    } catch (error) {
      log('Login error: $error');
      response = ResponseViewmodel(data: ResponseModel(msg: 'failed'));
    } finally {
      _loginload = false;
      notifyListeners(); // Notify listeners that loading has ended
    }

    return response;
  }

  // Get Products
  Future<List<ProductViewmodel>> getproducts() async {
    _productload = true;
    notifyListeners(); // Notify that products are loading

    try {
      final results = await ApiService().fetchProducts();
      productslist =
          results.map((item) => ProductViewmodel(data: item)).toList();
      log('productslist == $productslist');
    } catch (error) {
      log('Error fetching products: $error');
    } finally {
      _productload = false;
      notifyListeners(); // Notify listeners that loading has ended
    }

    return productslist;
  }

  // Register method
  bool _registerload = false;
  bool get registerload => _registerload;

  // ignore: body_might_complete_normally_nullable
  Future<ResponseViewmodel?> registration(
      String name, phone, address, username, password) async {
    try {
      _registerload = true;
      final results = await ApiService()
          .registration(name, phone, address, username, password);
      // ignore: unnecessary_null_comparison
      if (results == null) {
        throw Exception('Registration failed : No data returned');
      }
      response = ResponseViewmodel(data: results);
      log('Registration response === ${response!.msg}');
      notifyListeners();
      _registerload = false;
      return response;
    } catch (e) {}
  }
}
