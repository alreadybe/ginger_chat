import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_head_chat/pages/chat_page.dart';
import 'package:read_head_chat/pages/home_page.dart';
import 'package:read_head_chat/pages/initial_page.dart';
import 'package:read_head_chat/pages/login_page.dart';
import 'package:read_head_chat/pages/search_page.dart';
import 'package:read_head_chat/services/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>.value(
        value: AppProvider(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Ginger Chat',
            routes: {
              '/login': (context) => LoginPage(),
              '/search': (context) => SearchPage(),
              '/chat': (context) => ChatPage(),
              '/home': (context) => HomePage(),
            },
            theme: ThemeData(
              primaryColor: Color(0xFFDD571C),
              accentColor: Color(0xFFFEF9EB),
            ),
            home: InitialPage()));
  }
}
