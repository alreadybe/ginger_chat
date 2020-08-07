import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_head_chat/services/provider.dart';
import 'package:read_head_chat/services/storage.dart';

class SendMessageBar extends StatefulWidget {
  final chatRoomId;

  SendMessageBar({this.chatRoomId});

  @override
  _SendMessageBarState createState() => _SendMessageBarState(chatRoomId);
}

class _SendMessageBarState extends State<SendMessageBar> {
  final chatRoomId;

  _SendMessageBarState(this.chatRoomId);

  Storage _storage = Storage();

  TextEditingController inputController;

  @override
  void initState() {
    inputController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _provider = Provider.of<AppProvider>(context);

    return Container(
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: MediaQuery.of(context).size.width - 100,
                child: TextField(
                  controller: inputController,
                  style: TextStyle(color: Theme.of(context).accentColor),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Input ginger-message...',
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(
                  Icons.send,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  if (inputController.text.isNotEmpty) {
                    _storage.sendMessage(
                        chatRoomId, inputController.text, _provider.user.id);
                    inputController.text = '';
                    _storage.updateUnreadCounter(_provider.user.id, chatRoomId);
                  }
                },
              ),
            )
          ],
        ));
  }
}
