import 'package:flutter/cupertino.dart';
import 'package:read_head_chat/models/user.dart';

class AppProvider extends ChangeNotifier {
  User user;

  User findedUser;

  bool signup = false;
  bool initialRoute = true;

  int tabIndex = 0;

  void setInitialRoute(isInitial) {
    initialRoute = isInitial;
  }

  void setSearchResult(user) {
    findedUser = User(id: user.id, email: user.email, username: user.username);
    notifyListeners();
  }

  void changeTabIndex(newIndex) {
    tabIndex = newIndex;
    notifyListeners();
  }

  void setUser(User userData) {
    user = userData;
    notifyListeners();
  }

  void cleanUser() {
    user = null;
    signup = false;
    notifyListeners();
  }

  void toggleAuth() {
    signup = !signup;
    notifyListeners();
  }
}
