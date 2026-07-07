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

  bool hasAttemptedSubmit = false;

  String baseUrl = 'https://dummyjson.com/auth';

  void login() async {
    setState(() {
      isLoading = true;
      hasAttemptedSubmit = true;
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
            return ProfileScreen(token: token);
          },
        ),
      );
    } catch (err) {
      final snackBar = SnackBar(content: Text(err.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    http.get(Uri.parse('$baseUrl/login'));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Login", style: TextStyle(fontSize: 21))),
        body: Form(
          key: formKey,
          autovalidateMode: hasAttemptedSubmit
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  Text(
                    "Welcome Back!",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: username,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid username";
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "emilys"),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "emilyspass"),
                    onFieldSubmitted: (value) {
                      login();
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          login();
                        }
                      },
                      child: isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            )
                          : Text("Login"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
