import 'package:fleetdownloader/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc with ChangeNotifier {
  ThemeData get theme => darkMode ? AppTheme.darkApptheme : AppTheme.apptheme;
  bool _darkMode = false;
  bool get darkMode => _darkMode;
  set darkMode(bool value) {
    saveThemePreference(value);
    this._darkMode = value;
    notifyListeners();
  }

  bool _busy = false;
  bool get busy => _busy;
  set busy(bool value) {
    this._busy = value;
    notifyListeners();
  }

  AppBloc() {
    getThemePreference();
  }

  void saveThemePreference(bool value) async {
    var p = await SharedPreferences.getInstance();
    p.setBool('darkTheme', value);
  }

  getThemePreference() async {
    var p = await SharedPreferences.getInstance();
    bool value = p.getBool('darkTheme');
    if (value != null) darkMode = value;
  }
}
