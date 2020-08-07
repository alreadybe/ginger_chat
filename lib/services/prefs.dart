import 'package:read_head_chat/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Future<void> saveUserLogin(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.id);
    await prefs.setString('userName', user.username);
    await prefs.setString('userEmail', user.email);
  }

  Future getUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId');
    String username = prefs.getString('userName');
    String email = prefs.getString('userEmail');
    if (id == null || username == null || email == null) return null;
    return User(id: id, username: username, email: email);
  }

  Future<void> clearUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', null);
  }
}
