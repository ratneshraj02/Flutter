import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  final dbRef = FirebaseFirestore.instance.collection('users');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                child: ListView(
                  padding: EdgeInsets.all(15),
                  children: [
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Name",
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Email",
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        String id = DateTime.now().millisecondsSinceEpoch
                            .toString();

                        await dbRef.doc(id).set({
                          'id': id,
                          'name': name.text.trim(),
                          'email': email.text.trim(),
                        });

                        const snackBar = SnackBar(
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.green,
                          content: Text("Note Added"),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        setState(() {
                          isLoading = true;
                        });
                        Navigator.pop(context);
                      },
                      label: Text("Add User"),
                      icon: Icon(Icons.person),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
