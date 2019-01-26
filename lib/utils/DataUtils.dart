import 'package:shared_preferences/shared_preferences.dart';


class DataUtils{

  static final String SP_THEME_COLOR_INDEX = "colorThemeIndex";

  static setThemeColorIndex(int index) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt(SP_THEME_COLOR_INDEX, index);
  }

  static Future<int> getThemeColorIndex() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(SP_THEME_COLOR_INDEX);
  }
}