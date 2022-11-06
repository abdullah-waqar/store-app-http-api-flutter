// Importing http package as http
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rest_api/models/product.dart';

class ApiService {
  // This is the method to get all the products from the fake store api
  Future<List<Product>> getAllPosts() async {
    final allProductUrl = Uri.parse("https://fakestoreapi.com/products");

    final response = await http.get(allProductUrl);

    List<Product> allProducts = [];

    List body = json.decode(response.body);

    for (var product in body) {
      allProducts.add(product);
    }

    return allProducts;
  }

// This is the method to get single product from the fake store api
  Future getSingleProduct(int id) async {
    final singpleProductUrl =
        Uri.parse("https://fakestoreapi.com/products/$id");

    final response = await http.get(singpleProductUrl);

    print(response.statusCode);

    return json.decode(response.body);
  }

  Future getAllCategory() async {
    final allCategroyUrl =
        Uri.parse("https://fakestoreapi.com/products/categories");

    final response = await http.get(allCategroyUrl);

    return json.decode(response.body);
  }

  Future getProductByCategory(String catName) async {
    final productByCategoryUrl =
        Uri.parse("https://fakestoreapi.com/products/category/$catName");

    final response = await http.get(productByCategoryUrl);

    return json.decode(response.body);
  }

  Future getCart(String userId) async {
    final fetchCartUrl = Uri.parse("https://fakestoreapi.com/carts/$userId");
    final response = await http.get(fetchCartUrl);
    print(response.body);
    return json.decode(response.body);
  }

  // POST REQUEST

  Future userLogin(String username, String password) async {
    final loginUrl = Uri.parse("https://fakestoreapi.com/auth/login");
    // We have to send user name and the password to the body
    final response = await http.post(loginUrl, body: {
      'username': username,
      'password': password,
    });

    print(response.statusCode);

    print(response.body);

    return json.decode(response.body);
  }

  // PUT REQUEST

  Future updateCart(int userId, int productId) async {
    final updateCartUrl = Uri.parse("https://fakestoreapi.com/carts/$userId");

    final response = await http.put(updateCartUrl, body: {
      "userId": "$userId",
      "date": DateTime.now().toString(),
      "products": [
        {
          "productId": "$productId",
          "quantity": "1",
        }
      ].toString()
    });

    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  // DELETE REQUEST

  Future deleteCart(String userId) async {
    final deleteCartUrl = Uri.parse("https://fakestoreapi.com/carts/$userId");

    final response = await http.delete(deleteCartUrl);

    print(response.statusCode);
    print(response.body);

    return json.decode(response.body);
  }

// Basic Auth
  Future userAuthentication(String username, String password) async {
    // We dont have the api so we are just making the function

// Lets say we have any server such node js and we are making the authentication requset to the server

    final authUrl = Uri.parse("https://api.someApi.com");

    final response = await http.post(authUrl, body: {
      'username': username,
      'password': password,
    });
    print(response.statusCode);
    print(response.body);
  }

// Second method for auth using Authorization header

  Future userAuthorization(String username, String password) async {
    final authUrl = Uri.parse("https://api.someApi.com");
    // here we will send the requests by headers
    // First we will encode requests
    String basicAuth =
        "Basic " + base64Encode(utf8.encode("$username:$password"));

    final response = await http.get(authUrl, headers: {
      "Content-Type": "application/json",
      "authorization": basicAuth,
    });
    print(response.statusCode);
    print(response.body);
  }

// Bearer auth --> mean we have to authenticate the user using token instead of username and password

  Future userAuthenticationBearer(String username, String password) async {
    final authUrl = Uri.parse("some url");
    final accessToken = "Some token value";
    final response = await http.get(authUrl, headers: {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $accessToken'
    });

    print(response.statusCode);
    print(response.body);
  }
}
