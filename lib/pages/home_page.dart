import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_head_chat/models/chat.dart';
import 'package:read_head_chat/services/auth.dart';
import 'package:read_head_chat/services/prefs.dart';
import 'package:read_head_chat/services/provider.dart';
import 'package:read_head_chat/services/storage.dart';
import 'package:read_head_chat/widgets/category_selector.dart';
import 'package:read_head_chat/widgets/chat_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Auth _auth = Auth();
  Prefs _prefs = Prefs();
  Storage _storage = Storage();

  String userId;
  Stream chatsStream;

  @override
  void initState() {
    _prefs.getSavedUserId().then((value) => userId = value);
    _storage.getChatsList(userId).then((value) => chatsStream = value);
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
              _prefs.clearLogin();
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
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: StreamBuilder(
                  stream: chatsStream,
                  builder: (context, snapshot) => snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) => ChatItem(
                            userName: 'Keks',
                            lastMessage: 'text',
                            chatRoomId:
                                snapshot.data.documents[index].data['id'],
                          ),
                          physics: BouncingScrollPhysics(),
                        )
                      : Container()),
            ),
          )),
        ],
      ),
    );
  }
}
