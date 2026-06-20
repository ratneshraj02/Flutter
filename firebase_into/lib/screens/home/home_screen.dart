import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_into/auth/login_screen.dart';
import 'package:firebase_into/screens/adduser/add_user.dart';
import 'package:firebase_into/screens/updateUser/update_user_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbRef = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;

  void logoutNow() async {
    try {
      await auth.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (value) => false,
      );
    } catch (err) {
      final snackBar = SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        content: Text(err.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Firebase Database',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              logoutNow();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: dbRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data != null) {
            List<Map<String, dynamic>> users = [];

            for (var doc in snapshot.data!.docs) {
              users.add(doc.data());
            }

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Container(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    tileColor: Colors.white,
                    leading: Hero(
                      tag: '$index',
                      child: CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.deepPurple.shade100,
                        child: const Icon(Icons.note, color: Colors.deepPurple),
                      ),
                    ),
                    title: Text(
                      '${user['name']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text('${user['email']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return UpdateUser(user: user);
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await dbRef.doc(user['id']).delete();

                            const snackBar = SnackBar(
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.red,
                              content: Text(" note deleted"),
                            );

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(snackBar);
                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: Text("Not note Yet!"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddUser();
              },
            ),
          );
        },
        tooltip: 'Add user',
        child: const Icon(Icons.add_box, size: 40),
      ),
    );
  }
}
