import 'package:flutter/material.dart';
import 'package:noteapp/providers/auth/my_auth_provider.dart';
import 'package:noteapp/providers/note/note_provider.dart';
import 'package:noteapp/utils/router_helper.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteProvider>(context, listen: false).getNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 31,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text("Are you sure you want to logout"),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<MyAuthProvider>(
                                context,
                                listen: false,
                              ).logout();
                            },
                            child: Text("Logout"),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
        centerTitle: true,
        title: Text("Home"),
      ),
      body: Consumer<NoteProvider>(
        builder: (context, provider, child) {
          return provider.notes.isNotEmpty
              ? provider.loading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: provider.notes.length,
                        itemBuilder: (context, index) {
                          final note = provider.notes[index];
                          return ListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouterHelper.updateNote,
                                arguments: note,
                              );
                            },
                            title: Text(note.title),
                            subtitle: Text(note.description),
                            trailing: IconButton(
                              onPressed: () {
                                provider.deleteNote(note);
                              },
                              icon: Icon(
                                Icons.remove,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          );
                        },
                      )
              : Center(child: Text("Not note yet!!"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouterHelper.newNote);
        },
        tooltip: "Add note",
        child: Icon(Icons.add),
      ),
    );
  }
}
