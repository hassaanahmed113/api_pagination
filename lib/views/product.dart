import 'package:api_get/views/controller/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class ProductPage extends HookWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pProvider = Provider.of<ProductProvider>(context);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        pProvider.getProductData();
      });
      return null;
    });
    return SafeArea(
      child: Scaffold(
        body: Consumer<ProductProvider>(
          builder: (context, value, child) {
            if (value.products.isEmpty) {
              return const SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            } else {
              return NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification.metrics.pixels ==
                      scrollNotification.metrics.maxScrollExtent) {
                    pProvider.changeLength();
                  }
                  return false;
                },
                child: GridView.builder(
                  itemCount: pProvider.length,
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    var items = value.products[index];
                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                              height: 130,
                              width: 130,
                              child: Image.network(items['image'])),
                          Text(
                            items['title'],
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            items['rating']['rate'].toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
