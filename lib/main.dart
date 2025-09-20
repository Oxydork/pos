import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'halaman-login.dart';
import 'halaman-profil.dart';
import 'main-screen.dart';
import 'setting-page.dart';
import 'theme/bloc_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Login App',
            theme: themeState.themeData.copyWith(
              textTheme: themeState.themeData.textTheme.apply(
                fontFamily: 'Robot',
              ),
            ),
            initialRoute: '/login',
            debugShowCheckedModeBanner: false,

            routes: {
              '/login': (context) => LoginPage(),
              '/main': (context) => MainScreen(),
              '/profile': (context) => ProfilePage(),
              '/settings': (context) => SettingsPage(),
            },

            // Enhanced error handling
            onGenerateRoute: (settings) {
              print('Navigating to: ${settings.name}');

              switch (settings.name) {
                case '/login':
                  return _createRoute(LoginPage());
                case '/main':
                  return _createRoute(MainScreen());
                case '/profile':
                  return _createRoute(ProfilePage());
                case '/settings':
                  return _createRoute(SettingsPage());
                default:
                  return _createRoute(LoginPage());
              }
            },

            onUnknownRoute: (settings) {
              return _createRoute(
                Scaffold(
                  appBar: AppBar(title: Text('Page Not Found')),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.red),
                        SizedBox(height: 16),
                        Text('Halaman "${settings.name}" tidak ditemukan'),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pushReplacementNamed(context, '/login'),
                          child: Text('Kembali ke Login'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Custom route transition
  PageRouteBuilder _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}

// Navigation Helper Class
class AppNavigator {
  static void toLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  static void toMain(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/main');
  }

  static void toProfile(BuildContext context) {
    Navigator.pushNamed(context, '/profile');
  }

  static void toSettings(BuildContext context) {
    Navigator.pushNamed(context, '/settings');
  }

  static void pop(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}

// Extension untuk memudahkan navigasi
extension NavigationExtension on BuildContext {
  void navigateToLogin() => AppNavigator.toLogin(this);
  void navigateToMain() => AppNavigator.toMain(this);
  void navigateToProfile() => AppNavigator.toProfile(this);
  void navigateToSettings() => AppNavigator.toSettings(this);
  void goBack() => AppNavigator.pop(this);
}
