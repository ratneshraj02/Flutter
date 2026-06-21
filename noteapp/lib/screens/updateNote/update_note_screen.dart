import 'package:flutter/material.dart';
import 'package:noteapp/models/note_model.dart';
import 'package:noteapp/providers/note/note_provider.dart';
import 'package:provider/provider.dart';

class UpdateNoteScreen extends StatefulWidget {
  final NoteModel note;
  const UpdateNoteScreen({super.key, required this.note});

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    title.text = widget.note.title;
    description.text = widget.note.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update note"), centerTitle: true),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(15),
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the title';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the description';
                }
                return null;
              },
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Description",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Consumer<NoteProvider>(
              builder: (context, provider, child) {
                return provider.loading
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            provider.updateNote(
                              title.text.trim(),
                              description.text.trim(),
                              widget.note.id,
                            );
                          }
                        },
                        label: Text("Update Note"),
                        icon: Icon(Icons.note_alt_sharp),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
