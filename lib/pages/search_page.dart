import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_head_chat/pages/chat_page.dart';
import 'package:read_head_chat/services/provider.dart';
import 'package:read_head_chat/services/storage.dart';

import 'package:read_head_chat/widgets/search_app_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Storage _storage = Storage();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AppProvider _provider = Provider.of<AppProvider>(context);

    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: SearchAppBar()),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ))
            : Container(
                child: _provider.findedUser != null
                    ? Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _provider.findedUser.username,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isLoading = true;
                                });
                                _storage
                                    .getOrCreateChatRoom(
                                        _provider.user, _provider.findedUser)
                                    .then((chat) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatPage(
                                          chatRoomId: chat.id,
                                          username:
                                              _provider.findedUser.username,
                                        ),
                                      ));
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    'Message',
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))
                    : SizedBox()));
  }
}
