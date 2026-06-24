import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_with_api/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  String? token;
  ProfileScreen({super.key, required this.token});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String baseUrl = 'https://dummyjson.com/auth';

  Map<String, dynamic> user = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/me'),
        headers: {'Authorization': 'Bearer ${widget.token}'},
      );

      user = jsonDecode(response.body);
    } catch (err) {
      print(err);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              widget.token = '';
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
                (value) => false,
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(user["image"]),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: Text(
                          "${user["firstName"]} ${user["lastName"]}",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "@${user["username"]}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),

                      sectionTitle("Personal Information"),
                      infoTile("Email", user["email"], Icons.email),
                      infoTile("Phone", user["phone"], Icons.phone),
                      infoTile("Age", "${user["age"]}", Icons.cake),
                      infoTile("Gender", user["gender"], Icons.person),
                      infoTile(
                        "Blood Group",
                        user["bloodGroup"],
                        Icons.bloodtype,
                      ),
                      infoTile(
                        "Height & Weight",
                        "${user["height"]} cm / ${user["weight"]} kg",
                        Icons.monitor_weight,
                      ),

                      sectionTitle("Address"),
                      infoTile(
                        "Location",
                        "${user["address"]["address"]}, ${user["address"]["city"]}, ${user["address"]["state"]}, ${user["address"]["country"]}",
                        Icons.location_on,
                      ),

                      sectionTitle("Company"),
                      infoTile(
                        "Company",
                        user["company"]["name"],
                        Icons.business,
                      ),
                      infoTile(
                        "Department",
                        user["company"]["department"],
                        Icons.apartment,
                      ),
                      infoTile("Role", user["company"]["title"], Icons.work),

                      sectionTitle("Bank"),
                      infoTile(
                        "Card Type",
                        user["bank"]["cardType"],
                        Icons.credit_card,
                      ),
                      infoTile(
                        "Currency",
                        user["bank"]["currency"],
                        Icons.currency_exchange,
                      ),

                      sectionTitle("Crypto"),
                      infoTile(
                        "Coin",
                        user["crypto"]["coin"],
                        Icons.currency_bitcoin,
                      ),
                      infoTile("Network", user["crypto"]["network"], Icons.hub),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

Widget infoTile(String title, String value, IconData icon) {
  return ListTile(
    leading: Icon(icon, color: Colors.blue),
    title: Text(title),
    subtitle: Text(value),
  );
}

Widget sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    ),
  );
}
