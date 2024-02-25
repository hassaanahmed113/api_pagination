import 'package:api_get/views/domain/repo/pro_repo.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  ProductRepo repo = ProductRepo();
  List<dynamic> products = [];
  int length = 4;
  void changeLength() {
    if (length == 20) {
      length = 20;
    } else {
      length += 4;
    }
    notifyListeners();
  }

  Future<void> getProductData() async {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        products = await repo.getProductRepo();
        notifyListeners();
      },
    );
  }
}
