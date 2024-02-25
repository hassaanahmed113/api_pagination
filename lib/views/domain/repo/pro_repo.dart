import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  Future<dynamic> getProductRepo() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      debugPrint(data.toString());
      return data;
    } else {
      debugPrint(response.statusCode.toString());
    }
  }
}
