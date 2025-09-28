// lib/pages/home_page.dart
// HALAMAN UTAMA NOTEPAD HARIAN
import 'package:flutter/material.dart';
import 'package:pos/controller/notepad_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotepadController _controller;

  @override
  void initState() {
    super.initState();
    _controller = NotepadController();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addNote() {
    if (_controller.textController.text.trim().isNotEmpty) {
      _controller.addNote();
      _showSnackBar('Catatan berhasil ditambahkan', Colors.green);
    }
  }

  void _deleteNote(int index) {
    _controller.deleteNoteAt(index);
    _showSnackBar('Catatan dihapus', Colors.orange);
  }

  void _editNote(int index) {
    final note = _controller.getNoteAt(index);
    if (note != null) {
      _controller.setEditingText(note.text);
      _showEditDialog(note);
    }
  }

  void _showEditDialog(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.edit, color: Colors.blue),
            SizedBox(width: 8),
            Text('Edit Catatan'),
          ],
        ),
        content: TextField(
          controller: _controller.textController,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Tulis catatan Anda...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _controller.clearText();
              Navigator.pop(context);
            },
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final newText = _controller.textController.text.trim();
              if (newText.isNotEmpty) {
                _controller.updateNote(note.id, newText);
                _controller.clearText();
                Navigator.pop(context);
                _showSnackBar('Catatan berhasil diperbarui', Colors.blue);
              }
            },
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Semua Catatan'),
        content: Text('Apakah Anda yakin ingin menghapus semua catatan?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              _controller.clearAllNotes();
              Navigator.pop(context);
              _showSnackBar('Semua catatan dihapus', Colors.red);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _showNoteDetail(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.note, color: Colors.blue),
            SizedBox(width: 8),
            Text('Detail Catatan'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.text),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text(
                  '${_controller.formatTime(note.time)} • ${_controller.formatDate(note.time)}',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notepad Harian'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(),
            SizedBox(height: 24),
            _buildInputSection(),
            SizedBox(height: 24),
            _buildNotesHeader(),
            SizedBox(height: 12),
            _buildNotesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.note_add, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Text(
                'Notepad Harian',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Catat momen penting hari ini',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.edit_note,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 8),
                Text(
                  'Tulis Catatan Baru',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _controller.textController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Apa yang terjadi hari ini?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.all(12),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _addNote,
                icon: Icon(Icons.save),
                label: Text('Simpan Catatan'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Catatan Hari Ini (${_controller.notesCount})',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (_controller.hasNotes)
          TextButton.icon(
            onPressed: _showClearAllDialog,
            icon: Icon(Icons.clear_all, size: 18),
            label: Text('Hapus Semua'),
          ),
      ],
    );
  }

  Widget _buildNotesList() {
    return Expanded(
      child: _controller.hasNotes
          ? ListView.builder(
              itemCount: _controller.notesCount,
              itemBuilder: (context, index) {
                final note = _controller.getNoteAt(index)!;
                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      note.text,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: Colors.grey),
                          SizedBox(width: 4),
                          Text(
                            '${_controller.formatTime(note.time)} • ${_controller.formatDate(note.time)}',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    trailing: PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 20),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 20, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Hapus', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 'edit') {
                          _editNote(index);
                        } else if (value == 'delete') {
                          _deleteNote(index);
                        }
                      },
                    ),
                    onTap: () => _showNoteDetail(note),
                  ),
                );
              },
            )
          : _buildEmptyState(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_add_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'Belum ada catatan',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Mulai tulis catatan pertama Anda!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}