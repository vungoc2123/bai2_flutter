import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeModeNotifier extends StateNotifier<bool>{
  ThemeModeNotifier() : super(false);

  void toggleTheme(bool value){
      bool theme = value;
      state = theme;
  }

}