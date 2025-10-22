// lib/models/note_model.dart

class Note {
  final String id;
  final String text;
  final String userId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Note({
    required this.id,
    required this.text,
    required this.userId,
    required this.createdAt,
    this.updatedAt,
  });

  // Create Note from JSON (Appwrite document data)
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['\$id'] ?? json['id'] ?? '',
      text: json['text'] ?? '',
      userId: json['user_id'] ?? '',
      createdAt: json['\$createdAt'] != null
          ? DateTime.parse(json['\$createdAt'])
          : DateTime.now(),
      updatedAt: json['\$updatedAt'] != null
          ? DateTime.parse(json['\$updatedAt'])
          : null,
    );
  }

  // Convert Note to JSON
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'user_id': userId,
    };
  }
}
