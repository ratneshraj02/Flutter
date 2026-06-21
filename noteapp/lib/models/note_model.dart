class NoteModel {
  String id;
  String userId;
  String title;
  String description;
  DateTime createdAt;

  NoteModel(this.id, this.userId, this.title, this.description, this.createdAt);

  factory NoteModel.fromMap(Map<String, dynamic> map) => NoteModel(
    map['id'],
    map['userId'],
    map['title'],
    map['description'],
    DateTime.parse(map['createdAt']),
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'createdAt': createdAt.toString(),
    };
  }
}
