const tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [id, title, description, time, colorCode];

  static const String id = 'id';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
  static const String colorCode = 'colorCode';
}

class Notes {
  final int? id;
  final String? title;
  final String? description;
  final String? time;
  final String? colorCode;

  Notes({this.id, this.title, this.description, this.time, this.colorCode});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'time': time,
      'colorCode': colorCode,
    };
  }

  Notes.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        description = res["description"],
        time = res['time'],
        colorCode = res['colorCode'];

  @override
  String toString() {
    return 'Note{id: $id, name: $title, description: $description, time: $time, colorCode: $colorCode}';
  }
}
