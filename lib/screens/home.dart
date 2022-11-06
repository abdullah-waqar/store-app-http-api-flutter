import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rest_api/models/product.dart';
import 'package:rest_api/screens/all_category.dart';
import 'package:rest_api/screens/cart_screen.dart';
import 'package:rest_api/screens/product_detail.dart';
import 'package:rest_api/services/apiService.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllCategory()));
              },
              icon: const Icon(Icons.view_list)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              icon: const Icon(Icons.shopping_cart)),
        ],
      ),
      body: FutureBuilder(
          future: ApiService().getAllPosts(),
          builder: ((BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      Product product = snapshot.data![index];
                      return ListTile(
                        title: Text(product.title),
                        leading: Image.network(
                          product.image,
                          height: 50,
                          width: 30,
                        ),
                        subtitle: Text("Price - \$${product.price.toString()}"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      ProductDetail(id: product.id))));
                        },
                      );
                    }),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })),
    );
  }
}
