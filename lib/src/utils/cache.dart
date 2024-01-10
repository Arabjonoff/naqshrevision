import 'package:shared_preferences/shared_preferences.dart';
class CacheService {
  static SharedPreferences? preferences;

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }


  /// Save Permissions
  static void saveidSkl(int data) {
    preferences!.setInt("idSkl", data);
  }

  /// Get Permission
  static int getidSkl() {
    int data = preferences!.getInt("idSkl") ??1;
    return data;
  }

  static Future<bool> clear() async {
    return await preferences!.clear();
  }

  /// Token
  static void saveToken(String data) {
    preferences!.setString("token", data);
  }

  /// Save Password
  static void savePassword(String data) {
    preferences!.setString("password", data);
  }

  /// tip
  static void tip(int data) {
    preferences!.setInt("tip", data);
  }

  /// Save DataBase
  static void saveDb(String data) {
    preferences!.setString("saveDB", data);
  }

  static void id(int data) {
    preferences!.setInt("id", data);
  }

  static String getToken() {
    String data = preferences!.getString("token") ?? "";
    return data;
  }

  static String getPassword() {
    String data = preferences!.getString("password") ?? "";
    return data;
  }


  static String getTip() {
    String data = preferences!.getString("tip") ?? "";
    return data;
  }
  static int getId() {
    int data = preferences!.getInt("id") ??0;
    return data;
  }
  static String getIdSkl() {
    String data = preferences!.getString("id_skl") ?? "";
    return data;
  }
  static String getDb() {
    String data = preferences!.getString("saveDB") ?? '0';
    return data;
  }

  static String getName() {
    String data = preferences!.getString("saveClientName") ?? '';
    return data;
  }
  /// login
  static void saveLogin(String data) {
    preferences!.setString("user_login", data);
  }

  static String getLogin() {
    String data = preferences!.getString("user_login") ?? "";
    return data;
  }
  static int getFilterId() {
    int data = preferences!.getInt("filterId") ?? 0;
    return data;
  }





  /// order save
  /// /// //// ///// ////////////////////
  static void saveClientCode(String data) {
    preferences!.setString("saveClientCode", data);
  }
  static void saveClientName(String data) {
    preferences!.setString("saveClientName", data);
  }
  static void saveClientComment(String data) {
    preferences!.setString("saveClientComment", data);
  }

}

class ThemePreferences {
  // ignore: constant_identifier_names
  static const String KEY_SELECTED_THEME = 'Theme';
  static SharedPreferences? preferences;

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static void saveTheme(int selectedTheme) {
    preferences!.setInt(KEY_SELECTED_THEME, selectedTheme);
  }

  static bool getDarkMode() {
    int theme = preferences!.getInt(KEY_SELECTED_THEME) ?? 1;
    if (theme == 1) {
      return true;
    } else {
      return false;
    }
  }

  static int getThemeAll() {
    int theme = preferences!.getInt(KEY_SELECTED_THEME) ?? 1;
    return theme;
  }

}
