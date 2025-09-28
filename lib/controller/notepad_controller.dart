// lib/controllers/notepad_controller.dart
import 'package:flutter/material.dart';

class Note {
  final String id;
  String text;
  DateTime time;

  Note({
    required this.id,
    required this.text,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      text: json['text'],
      time: DateTime.fromMillisecondsSinceEpoch(json['time']),
    );
  }
}

class NotepadController extends ChangeNotifier {
  final TextEditingController textController = TextEditingController();
  final List<Note> _notes = [];

  List<Note> get notes => List.unmodifiable(_notes);
  int get notesCount => _notes.length;
  bool get hasNotes => _notes.isNotEmpty;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  // Add new note
  void addNote() {
    final text = textController.text.trim();
    if (text.isNotEmpty) {
      final note = Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: text,
        time: DateTime.now(),
      );
      
      _notes.insert(0, note);
      textController.clear();
      notifyListeners();
    }
  }

  // Update existing note
  void updateNote(String noteId, String newText) {
    final index = _notes.indexWhere((note) => note.id == noteId);
    if (index != -1 && newText.trim().isNotEmpty) {
      _notes[index].text = newText.trim();
      _notes[index].time = DateTime.now();
      notifyListeners();
    }
  }

  // Delete note by id
  void deleteNote(String noteId) {
    _notes.removeWhere((note) => note.id == noteId);
    notifyListeners();
  }

  // Delete note by index
  void deleteNoteAt(int index) {
    if (index >= 0 && index < _notes.length) {
      _notes.removeAt(index);
      notifyListeners();
    }
  }

  // Clear all notes
  void clearAllNotes() {
    _notes.clear();
    notifyListeners();
  }

  // Get note by id
  Note? getNoteById(String noteId) {
    try {
      return _notes.firstWhere((note) => note.id == noteId);
    } catch (e) {
      return null;
    }
  }

  // Get note by index
  Note? getNoteAt(int index) {
    if (index >= 0 && index < _notes.length) {
      return _notes[index];
    }
    return null;
  }

  // Set text to controller for editing
  void setEditingText(String text) {
    textController.text = text;
  }

  // Clear text controller
  void clearText() {
    textController.clear();
  }

  // Search notes (bonus feature)
  List<Note> searchNotes(String query) {
    if (query.trim().isEmpty) return notes;
    
    return _notes
        .where((note) => note.text.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Get notes by date (bonus feature)
  List<Note> getNotesByDate(DateTime date) {
    return _notes.where((note) {
      return note.time.year == date.year &&
             note.time.month == date.month &&
             note.time.day == date.day;
    }).toList();
  }

  // Get today's notes
  List<Note> getTodayNotes() {
    return getNotesByDate(DateTime.now());
  }

  // Format time helper
  String formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  // Format date helper
  String formatDate(DateTime time) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
    ];
    return '${time.day} ${months[time.month - 1]} ${time.year}';
  }

  // Format relative time (bonus feature)
  String formatRelativeTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'Baru saja';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inDays == 1) {
      return 'Kemarin';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari lalu';
    } else {
      return formatDate(time);
    }
  }

  // Validate note text
  bool isValidNoteText(String text) {
    return text.trim().isNotEmpty && text.trim().length >= 1;
  }

  // Get statistics (bonus feature)
  Map<String, dynamic> getStatistics() {
    final now = DateTime.now();
    final today = getNotesByDate(now);
    final yesterday = getNotesByDate(now.subtract(Duration(days: 1)));
    
    return {
      'total_notes': _notes.length,
      'today_notes': today.length,
      'yesterday_notes': yesterday.length,
      'total_characters': _notes.fold(0, (sum, note) => sum + note.text.length),
      'average_note_length': _notes.isEmpty 
          ? 0 
          : (_notes.fold(0, (sum, note) => sum + note.text.length) / _notes.length).round(),
    };
  }
}