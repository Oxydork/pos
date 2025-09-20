import 'package:flutter/material.dart';

class Controller {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  // Settings properties
  bool _notifikasi = true;
  String _bahasa = 'Indonesia';

  // Getters
  bool get isLoading => _isLoading;
  bool get obscurePassword => _obscurePassword;
  bool get notifikasi => _notifikasi;
  String get bahasa => _bahasa;

  // Private callback untuk update UI
  VoidCallback? _updateUI;

  // Set callback untuk update UI dari widget
  void setUpdateCallback(VoidCallback callback) {
    _updateUI = callback;
  }

  // Toggle visibility password
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    _updateUI?.call();
  }

  // Settings methods
  void toggleNotifikasi() {
    _notifikasi = !_notifikasi;
    _updateUI?.call();
  }

  void setBahasa(String bahasa) {
    _bahasa = bahasa;
    _updateUI?.call();
  }

  // Validasi email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!value.contains('@')) {
      return 'Format email tidak valid';
    }
    return null;
  }

  // Validasi password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  // Handle login process - REVISED WITH NAVIGATION
  Future<bool> handleLogin() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    _setLoading(true);

    try {
      // Simulasi API call
      await _authenticateUser(emailController.text, passwordController.text);
      _setLoading(false);
      return true;
    } catch (e) {
      _setLoading(false);
      return false;
    }
  }

  // Simulasi proses autentikasi
  Future<void> _authenticateUser(String email, String password) async {
    // Simulasi delay network request
    await Future.delayed(Duration(seconds: 2));

    // Contoh: call API, check database, dll
    if (email == "adrian@test.com" && password == "123456") {
      // Login berhasil
      return;
    } else {
      // Login gagal
      throw Exception('Login gagal');
    }
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    _updateUI?.call();
  }

  // Handle forgot password
  void handleForgotPassword(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Fitur lupa password akan segera hadir'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  // Handle register
  void handleRegister(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Halaman registrasi akan segera hadir'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Settings handlers
  void handleNotifikasiToggle(BuildContext context) {
    toggleNotifikasi();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _notifikasi ? 'Notifikasi diaktifkan' : 'Notifikasi dinonaktifkan',
        ),
        backgroundColor: _notifikasi ? Colors.green : Colors.orange,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void handleBahasaSelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pilih Bahasa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Indonesia'),
                leading: Radio<String>(
                  value: 'Indonesia',
                  groupValue: _bahasa,
                  onChanged: (String? value) {
                    if (value != null) {
                      setBahasa(value);
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Bahasa diubah ke Indonesia'),
                          backgroundColor: Colors.blue,
                        ),
                      );
                    }
                  },
                ),
              ),
              ListTile(
                title: Text('English'),
                leading: Radio<String>(
                  value: 'English',
                  groupValue: _bahasa,
                  onChanged: (String? value) {
                    if (value != null) {
                      setBahasa(value);
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Language changed to English'),
                          backgroundColor: Colors.blue,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  void handleTentangAplikasi(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Aplikasi Sederhana',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2024 Developer',
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            'Aplikasi Flutter sederhana dengan 3 halaman utama dan tema dinamis.',
          ),
        ),
      ],
    );
  }

  void handleBantuan(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Fitur bantuan akan segera hadir!'),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.logout, color: Colors.orange),
              SizedBox(width: 8),
              Text('Konfirmasi Logout'),
            ],
          ),
          content: Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.pushReplacementNamed(
                  context,
                  '/login',
                ); // Back to login

                // Clear form data
                emailController.clear();
                passwordController.clear();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Logout berhasil'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  // REVISED: Show success dialog with navigation
  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 8),
            Text('Login Berhasil!'),
          ],
        ),
        content: Text('Selamat datang, ${emailController.text}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.pushReplacementNamed(
                context,
                '/main',
              ); // Navigate to main
            },
            style: TextButton.styleFrom(foregroundColor: Color(0xFF667eea)),
            child: Text('LANJUTKAN'),
          ),
        ],
      ),
    );
  }

  // Show error dialog with retry option
  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red, size: 28),
            SizedBox(width: 8),
            Text('Login Gagal!'),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('COBA LAGI'),
          ),
        ],
      ),
    );
  }

  // Dispose resources
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
