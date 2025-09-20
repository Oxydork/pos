// lib/pages/profile_page.dart
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.green[100],
              child: Icon(Icons.person, size: 80, color: Colors.green[700]),
            ),
            SizedBox(height: 24),
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.green),
                      title: Text('Nama'),
                      subtitle: Text('John Doe'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.email, color: Colors.green),
                      title: Text('Email'),
                      subtitle: Text('john.doe@example.com'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.phone, color: Colors.green),
                      title: Text('Telepon'),
                      subtitle: Text('+62 812 3456 7890'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.location_on, color: Colors.green),
                      title: Text('Lokasi'),
                      subtitle: Text('Jakarta, Indonesia'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Edit Profil'),
                      content: Text('Fitur edit profil akan segera hadir!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.edit),
              label: Text('Edit Profil'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
