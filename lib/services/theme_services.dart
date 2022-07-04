import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class ThemeServices {
  final GetStorage _box = GetStorage();
  final _key = 'isDarkMode';
  bool _loadthemefromBox() => _box.read<bool>(_key) ?? false;

  _savethemetoBox(bool _isDarkMode) => _box.write(_key, _isDarkMode);

  ThemeMode get theme => _loadthemefromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_loadthemefromBox() ? ThemeMode.light : ThemeMode.dark);
    _savethemetoBox(!_loadthemefromBox());
  }

  bool getTheme() {
    print(_loadthemefromBox());
    return _loadthemefromBox();
  }

  void select_savetheme(ThemeMode theme) {
    Get.changeThemeMode(theme);
    _savethemetoBox(!_loadthemefromBox());
  }
}
