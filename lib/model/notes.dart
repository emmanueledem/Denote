const tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [id, title, description, time, colorCode];

  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
  static const String colorCode = 'colorCode';
}

class Notes {
  final int? id;
  final String? title;
  final String? decription;
  final String time;
  final String colorCode;

  Notes(this.id, this.title, this.decription, this.time, this.colorCode);
}
