import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

part 'theme_events.dart';

part 'theme_states.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  late ThemeMode? mode;

  ThemeBloc() : super(ThemeInitial()) {
    on<ChangeTheme>(_changeTheme);
    on<LoadTheme>(_loadTheme);
  }

  void _loadTheme(LoadTheme event, Emitter<ThemeState> emit) {
    mode = event.isDarkMode ? ThemeMode.dark : ThemeMode.light;

    emit(ThemeChanged(isDarkMode: event.isDarkMode));
  }

  void _changeTheme(ChangeTheme event, Emitter<ThemeState> emit) {
    preferences?.setString(
        'theme', event.isDarkMode == true ? 'dark' : 'light');
    mode = event.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    emit(ThemeChanged(isDarkMode: event.isDarkMode));
  }
}
