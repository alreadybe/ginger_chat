import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_head_chat/services/prefs.dart';
import 'package:read_head_chat/services/provider.dart';
import 'package:read_head_chat/services/storage.dart';

class InitialPage extends StatelessWidget {
  final Storage _storage = Storage();
  final Prefs _prefs = Prefs();

  @override
  Widget build(BuildContext context) {
    AppProvider _provider = Provider.of<AppProvider>(context);

    if (_provider.initialRoute) {
      _provider.setInitialRoute(false);
      _prefs.getSavedUserId().then((userId) {
        if (userId != null) {
          _storage.getUserById(userId).then((user) {
            _provider.setUser(user, null);
          }).catchError((e) {
            print(e);
          });
        }
        Navigator.pushReplacementNamed(
            context, userId != null ? '/home' : '/login');
      }).catchError((e) {
        throw new Exception(e);
      });
    }

    return SafeArea(
        child: Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    ));
  }
}
