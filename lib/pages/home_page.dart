import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_head_chat/services/auth.dart';
import 'package:read_head_chat/services/prefs.dart';
import 'package:read_head_chat/services/provider.dart';
import 'package:read_head_chat/services/storage.dart';
import 'package:read_head_chat/widgets/category_selector.dart';
import 'package:read_head_chat/widgets/chat_list.dart';
import 'package:read_head_chat/widgets/user_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Auth _auth = Auth();
  Prefs _prefs = Prefs();

  Storage _storage = Storage();

  Stream chatsStream;

  @override
  void initState() {
    _storage.getChatsList().then((value) => chatsStream = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _provider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.search),
          iconSize: 30,
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/search',
            );
          },
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Ginger Chat',
          style: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _auth.signOut();
              _prefs.clearUserLogin();
              _provider.cleanUser();
              Navigator.pushNamed(context, '/login');
            },
          )
        ],
      ),
      body: Column(
        children: [
          CategorySelector(),
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      )),
                  child: _provider.user != null
                      ? (_provider.tabIndex == 0
                          ? ChatList(chatsStream: chatsStream)
                          : UserList())
                      : Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ))),
        ],
      ),
    );
  }
}
