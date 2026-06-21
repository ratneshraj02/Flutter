import 'package:flutter/material.dart';
import 'package:noteapp/providers/auth/my_auth_provider.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController email = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Forgot Password")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Center(
              child: Stack(
                children: [
                  Image.asset('assets/images/app_logo.png', height: 100),
                  Positioned(
                    top: 32,
                    left: 12,
                    child: Text(
                      "NOTE\nAPPLICATION",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: email,
               validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }

                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                if (!emailRegex.hasMatch(value)) {
                  return 'Enter a valid email';
                }

                return null;
              },
              decoration: InputDecoration(
                hintText: "john@gmail.com",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Consumer<MyAuthProvider>(
              builder: (ctx, provider, child) {
                return ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      provider.forgotPassword(email: email.text.trim());
                    }
                  },
                  label: Text(
                    "Reset password",
                    style: TextStyle(color: Colors.black),
                  ),
                  icon: Icon(Icons.person, size: 30, color: Colors.black),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
