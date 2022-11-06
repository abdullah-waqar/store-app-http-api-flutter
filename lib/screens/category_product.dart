import 'package:flutter/material.dart';
import 'package:rest_api/screens/product_detail.dart';
import 'package:rest_api/services/apiService.dart';

class CategoryProductScreen extends StatelessWidget {
  final String categoryName;
  CategoryProductScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryName.toUpperCase()),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: FutureBuilder(
            future: ApiService().getProductByCategory(categoryName),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index]['title']),
                        leading: Image.network(
                          snapshot.data[index]['image'],
                          height: 50,
                          width: 30,
                        ),
                        subtitle: Text("Price - \$${snapshot.data[index]['price']}"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ProductDetail(
                                        id: snapshot.data[index]['id'],
                                      ))));
                        },
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
