import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_with_api/profile_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;

  String baseUrl = 'https://dummyjson.com/auth';

  void login() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        body: jsonEncode({
          'username': username.text.trim(),
          'password': password.text.trim(),
        }),
        headers: {'Content-type': 'application/json'},
      );
      final data = jsonDecode(response.body);
      String token = data['accessToken'];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ProfileScreen(token :token);
          },
        ),
      );
    } catch (err) {
      print("Error : ${err.toString()}");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    http.get(Uri.parse('$baseUrl/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login", style: TextStyle(fontSize: 21))),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: username,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter valid username";
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "username"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: password,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Please enter email";
                    return null;
                  },
                  decoration: InputDecoration(hintText: "password"),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      login();
                    }
                  },
                  label: isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                      : Text("Login"),
                  icon: Icon(Icons.person),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
