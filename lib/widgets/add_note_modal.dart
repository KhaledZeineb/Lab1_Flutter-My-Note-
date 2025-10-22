// lib/widgets/add_note_modal.dart
import 'package:flutter/material.dart';

class AddNoteModal extends StatefulWidget {
  final Function(String) onAdd;

  const AddNoteModal({Key? key, required this.onAdd}) : super(key: key);

  @override
  _AddNoteModalState createState() => _AddNoteModalState();
}

class _AddNoteModalState extends State<AddNoteModal> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onAdd(_controller.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add New Note',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _controller,
            autofocus: true,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Enter your note...',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Add'),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
