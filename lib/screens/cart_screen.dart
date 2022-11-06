import 'package:flutter/material.dart';
import 'package:rest_api/services/apiService.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      // First we are getting the list of products
      // from the api using future builder
      body: FutureBuilder(
          future: ApiService().getCart("1"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List products = snapshot.data['products'];

              return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: ((context, index) {
                    // // Now we are getting the actual prodctus
                    return FutureBuilder(
                        future: ApiService()
                            .getSingleProduct(products[index]['productId']),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListTile(
                              title: Text(snapshot.data['title']),
                              leading: Image.network(
                                snapshot.data['image'],
                                height: 50,
                                width: 30,
                              ),
                              subtitle: Text(
                                  "Quantity -${products[index]['quantity']}"),
                              trailing: IconButton(
                                onPressed: () async {
                                  await ApiService().deleteCart('1');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Item deleted Successfully")));
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          } else {
                            return const LinearProgressIndicator();
                          }
                        });
                  }));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),

      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        color: Colors.green,
        child: const Center(
          child: Text(
            "Order Now",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
