// lib/screens/notes_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note_model.dart';
import '../services/note_service.dart';
import '../widgets/note_item.dart';
import '../widgets/add_note_modal.dart';
import '../providers/auth_provider.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Note> notes = [];
  bool isLoading = true;
  final NoteService _noteService = NoteService();

  @override
  void initState() {
    super.initState();
    _fetchNotes();
  }

  Future<void> _fetchNotes() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.user == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      // Pass the user ID when fetching notes
      final fetchedNotes = await _noteService.getNotes(authProvider.user!.$id);
      setState(() {
        notes = fetchedNotes;
        isLoading = false;
      });
    } catch (e) {
      print('Failed to fetch notes: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _addNote(String text) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.user == null) return;

    try {
      // Pass the user ID when adding a note
      final newNote = await _noteService.addNote(text, authProvider.user!.$id);
      if (newNote != null) {
        setState(() {
          notes.insert(0, newNote);
        });
        Navigator.of(context).pop(); // Close the modal
      }
    } catch (e) {
      print('Failed to add note: $e');
    }
  }

  Future<void> _deleteNote(String noteId) async {
    try {
      final success = await _noteService.deleteNote(noteId);
      if (success) {
        setState(() {
          notes.removeWhere((note) => note.id == noteId);
        });
      }
    } catch (e) {
      print('Failed to delete note: $e');
    }
  }

  void _showAddNoteModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddNoteModal(onAdd: _addNote),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header with title and add button
          Container(
            height: 100,
            color: Colors.blue,
            padding: EdgeInsets.only(
              bottom: 15,
              left: 20,
              right: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Notes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: _showAddNoteModal,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Notes list or empty state
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : notes.isNotEmpty
                    ? RefreshIndicator(
                        onRefresh: _fetchNotes,
                        child: ListView.builder(
                          padding: EdgeInsets.all(15),
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            return NoteItem(
                              note: notes[index],
                              onDelete: () => _deleteNote(notes[index].id),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Text(
                          'No notes yet. Create one!',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF7F8C8D),
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}