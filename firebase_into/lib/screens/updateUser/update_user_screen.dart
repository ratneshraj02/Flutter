import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateUser extends StatefulWidget {
  final Map<String, dynamic> user;

  const UpdateUser({super.key, required this.user});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  final dbRef = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    name.text = widget.user['name'];
    email.text = widget.user['email'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update user",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: Form(
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
                  await dbRef.doc(widget.user['id']).update({
                    'name' : name.text.trim(),
                    'email' : email.text.trim()
                  });

                  const snackBar = SnackBar(
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.green,
                    content: Text("Note Updated"),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  Navigator.pop(context);
                },
                label: Text("Update User"),
                icon: Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
