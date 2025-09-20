// lib/theme/bloc_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

class SetLightThemeEvent extends ThemeEvent {}

class SetDarkThemeEvent extends ThemeEvent {}

// States
abstract class ThemeState {
  final ThemeData themeData;
  final bool isDarkMode;

  ThemeState({required this.themeData, required this.isDarkMode});
}

class LightThemeState extends ThemeState {
  LightThemeState()
    : super(themeData: ThemeData.light(useMaterial3: true), isDarkMode: false);
}

class DarkThemeState extends ThemeState {
  DarkThemeState()
    : super(themeData: ThemeData.dark(useMaterial3: true), isDarkMode: true);
}

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightThemeState()) {
    on<ToggleThemeEvent>((event, emit) {
      if (state.isDarkMode) {
        emit(LightThemeState());
      } else {
        emit(DarkThemeState());
      }
    });

    on<SetLightThemeEvent>((event, emit) {
      emit(LightThemeState());
    });

    on<SetDarkThemeEvent>((event, emit) {
      emit(DarkThemeState());
    });
  }
}
