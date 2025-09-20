// lib/settings_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './theme/bloc_theme.dart';
import 'page_controller.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Controller _controller;

  @override
  void initState() {
    super.initState();
    _controller = Controller();
    _controller.setUpdateCallback(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Theme Section
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.palette, color: Colors.purple),
                      SizedBox(width: 8),
                      Text(
                        'Tampilan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      return SwitchListTile(
                        title: Text('Mode Gelap'),
                        subtitle: Text(state.isDarkMode ? 'Aktif' : 'Nonaktif'),
                        value: state.isDarkMode,
                        activeColor: Colors.purple,
                        onChanged: (bool value) {
                          context.read<ThemeBloc>().add(ToggleThemeEvent());
                        },
                        secondary: Icon(
                          state.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                          color: Colors.purple,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 16),
          
          // Notifications Section
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.notifications, color: Colors.purple),
                      SizedBox(width: 8),
                      Text(
                        'Notifikasi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  SwitchListTile(
                    title: Text('Notifikasi Push'),
                    subtitle: Text(_controller.notifikasi ? 'Aktif' : 'Nonaktif'),
                    value: _controller.notifikasi,
                    activeColor: Colors.purple,
                    onChanged: (bool value) {
                      _controller.handleNotifikasiToggle(context);
                    },
                    secondary: Icon(
                      _controller.notifikasi 
                          ? Icons.notifications_active 
                          : Icons.notifications_off,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 16),
          
          // Language Section
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.language, color: Colors.purple),
                      SizedBox(width: 8),
                      Text(
                        'Bahasa',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    title: Text('Bahasa Aplikasi'),
                    subtitle: Text(_controller.bahasa),
                    leading: Icon(Icons.translate, color: Colors.purple),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () => _controller.handleBahasaSelection(context),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 16),
          
          // Other Settings Section
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.settings, color: Colors.purple),
                      SizedBox(width: 8),
                      Text(
                        'Lainnya',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    title: Text('Tentang Aplikasi'),
                    leading: Icon(Icons.info, color: Colors.purple),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () => _controller.handleTentangAplikasi(context),
                  ),
                  ListTile(
                    title: Text('Bantuan'),
                    leading: Icon(Icons.help, color: Colors.purple),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () => _controller.handleBantuan(context),
                  ),
                  ListTile(
                    title: Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                    leading: Icon(Icons.logout, color: Colors.red),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.red),
                    onTap: () => _controller.handleLogout(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}