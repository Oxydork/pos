import 'package:flutter/material.dart';

class LoginController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  // Getters
  bool get isLoading => _isLoading;
  bool get obscurePassword => _obscurePassword;

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

  // Handle login process
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

  // Show success dialog
  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
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
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(foregroundColor: Color(0xFF667eea)),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Show error dialog
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
            child: Text('Coba Lagi'),
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
