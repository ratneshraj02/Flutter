import 'package:flutter/material.dart';
import 'package:noteapp/providers/auth/my_auth_provider.dart';
import 'package:noteapp/utils/router_helper.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Register")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            const SizedBox(height: 60),
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
            const SizedBox(height: 40),
            TextFormField(
              controller: name,
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
                hintText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the email';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: password,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }

                final passwordRegex = RegExp(
                  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                );

                if (!passwordRegex.hasMatch(value)) {
                  return 'Password must contain:\n'
                      '• 8+ characters\n'
                      '• Uppercase letter\n'
                      '• Lowercase letter\n'
                      '• Number\n'
                      '• Special character';
                }

                return null;
              },
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Consumer<MyAuthProvider>(
              builder: (context, provider, child) {
                return provider.loading
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            provider.register(
                              name: name.text.trim(),
                              email: email.text.trim(),
                              password: password.text.trim(),
                            );
                          }
                        },
                        label: Text(
                          "Register",
                          style: TextStyle(color: Colors.black),
                        ),
                        icon: Icon(Icons.person, size: 30, color: Colors.black),
                      );
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouterHelper.login);
                  },
                  child: Text("Login now"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
