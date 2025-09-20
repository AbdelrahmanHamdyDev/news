import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<int> {
  // 0 => dark
  // 1 => light
  ThemeCubit() : super(1);

  void toggleTheme() {
    emit(state == 0 ? 1 : 0);
  }

  ThemeMode get themeMode {
    return state == 0 ? ThemeMode.dark : ThemeMode.light;
  }
}
