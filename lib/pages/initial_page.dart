import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_head_chat/services/prefs.dart';
import 'package:read_head_chat/services/provider.dart';

class InitialPage extends StatelessWidget {
  final Prefs _prefs = Prefs();

  @override
  Widget build(BuildContext context) {
    AppProvider _provider = Provider.of<AppProvider>(context);

    if (_provider.initialRoute) {
      _provider.setInitialRoute(false);
      _prefs.getUserLogin().then((user) {
        if (user != null) {
          _provider.setUser(user);
        }
        Navigator.pushReplacementNamed(
            context, user != null ? '/home' : '/login');
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
