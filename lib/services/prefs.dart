import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Future<void> saveLogin(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', id);
  }

  Future getSavedUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    return userId;
  }

  Future<void> clearLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', null);
  }
}
