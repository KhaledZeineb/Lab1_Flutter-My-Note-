// services/note_service.dart
import 'package:appwrite/appwrite.dart';
import '../models/note_model.dart';
import '../config/appwrite_config.dart';

class NoteService {
  final Databases databases;

  NoteService() : databases = Databases(AppwriteConfig.client);

  Future<List<Note>> getNotes(String userId) async {
    try {
      final response = await databases.listDocuments(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.collectionId,
        queries: [
          Query.equal('user_id', userId) // Filter by user_id
        ],
      );

      return response.documents.map((doc) => Note.fromJson(doc.data)).toList();
    } catch (e) {
      print('Error fetching notes: $e');
      return [];
    }
  }

  Future<Note?> addNote(String text, String userId) async {
    try {
      final response = await databases.createDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.collectionId,
        documentId: ID.unique(),
        data: {
          'text': text,
          'user_id': userId // Add user ID to the note
        },
        permissions: [
          Permission.read(Role.user(userId)),
          Permission.update(Role.user(userId)),
          Permission.delete(Role.user(userId)),
        ],
      );

      return Note.fromJson(response.data);
    } catch (e) {
      print('Error adding note: $e');
      return null;
    }
  }

  Future<Note?> updateNote(String noteId, String text) async {
    try {
      final response = await databases.updateDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.collectionId,
        documentId: noteId,
        data: {
          'text': text,
        },
      );

      return Note.fromJson(response.data);
    } catch (e) {
      print('Error updating note: $e');
      return null;
    }
  }

  Future<bool> deleteNote(String noteId) async {
    try {
      await databases.deleteDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.collectionId,
        documentId: noteId,
      );
      return true;
    } catch (e) {
      print('Error deleting note: $e');
      return false;
    }
  }
}