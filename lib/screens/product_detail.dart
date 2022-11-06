import 'package:flutter/material.dart';
import 'package:rest_api/services/apiService.dart';

class ProductDetail extends StatelessWidget {
  final int id;
  ProductDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
          future: ApiService().getSingleProduct(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Image.network(
                        snapshot.data['image'],
                        height: 200,
                        width: double.infinity,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "\$" + snapshot.data['price'].toString(),
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data['title'],
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Chip(
                        label: Text(
                          snapshot.data['category'].toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.blueGrey,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Center(
                        child: Text(
                          "ABOUT PRODUCT ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data['description'],
                        style: const TextStyle(
                            fontSize: 19,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart_outlined),
        backgroundColor: Colors.green,
        onPressed: () async {
          await ApiService().updateCart(1, id);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Product added to cart")));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
