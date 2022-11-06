import 'package:flutter/material.dart';
import 'package:rest_api/screens/home.dart';
import 'package:rest_api/services/apiService.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController nameController =
      TextEditingController(text: "mor_2314");
  TextEditingController passwordController =
      TextEditingController(text: "83r5^_");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  final getToken = await ApiService()
                      .userLogin(nameController.text, passwordController.text);
                  if (getToken['token'] != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Success your token id is ${getToken['token']}",
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // I want to show this snakbar for two seconds
                    // then nav to home screen
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => HomePage())));
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Username or password is incorrect",
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
