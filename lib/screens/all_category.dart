import 'package:flutter/material.dart';
import 'package:rest_api/screens/category_product.dart';
import 'package:rest_api/services/apiService.dart';

class AllCategory extends StatelessWidget {
  const AllCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiService().getAllCategory(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryProductScreen(
                                  categoryName: snapshot.data[index])));
                    },
                    child: Card(
                      elevation: 0,
                      margin: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        child: Center(
                          child: Text(
                            snapshot.data[index].toString().toUpperCase(),
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
