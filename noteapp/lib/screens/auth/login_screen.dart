import 'package:flutter/material.dart';
import 'package:noteapp/providers/auth/my_auth_provider.dart';
import 'package:noteapp/utils/router_helper.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Login")),
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
            const SizedBox(height: 60),
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
                return provider.loading? Center(child: CircularProgressIndicator(),) : ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      provider.login(email.text.trim(), password.text.trim());
                    }
                  },
                  label: Text("Login", style: TextStyle(color: Colors.black)),
                  icon: Icon(Icons.person, size: 30, color: Colors.black),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouterHelper.forgotPassword);
                  },
                  child: Text("forgot passwordI"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouterHelper.register);
                  },
                  child: Text("Register now"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
