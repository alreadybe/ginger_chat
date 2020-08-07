import 'package:flutter/material.dart';
import 'package:read_head_chat/models/message.dart';
import 'package:read_head_chat/services/prefs.dart';
import 'package:read_head_chat/services/storage.dart';
import 'package:read_head_chat/widgets/message_item.dart';
import 'package:read_head_chat/widgets/send_message_bar.dart';

class ChatPage extends StatefulWidget {
  final String chatRoomId;
  final String username;

  ChatPage({this.chatRoomId, this.username});

  @override
  _ChatPageState createState() =>
      _ChatPageState(this.chatRoomId, this.username);
}

class _ChatPageState extends State<ChatPage> {
  final String chatRoomId;
  final String username;

  _ChatPageState(this.chatRoomId, this.username);

  Storage _storage = Storage();
  Prefs _prefs = Prefs();

  bool isLoading = true;
  Stream messagesStream;

  @override
  void initState() {
    _storage.getConversations(chatRoomId).then((value) {
      _prefs.getUserLogin().then((value) => null);
      setState(() {
        messagesStream = value;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(username),
        ),
        backgroundColor: Theme.of(context).accentColor,
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ))
            : Container(
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                            child: StreamBuilder(
                                stream: messagesStream,
                                builder: (context, snapshot) => snapshot.hasData
                                    ? _chatList(snapshot)
                                    : Center(
                                        child: CircularProgressIndicator(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                      ))))),
                    SendMessageBar(
                      chatRoomId: chatRoomId,
                    ),
                  ],
                ),
              ));
  }
}

Widget _chatList(snapshot) {
  return snapshot.data.documents.length > 0
      ? ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            Message message =
                Message.fromMap(snapshot.data.documents[index].data);
            return MessageItem(message);
          })
      : Center(
          child: Text('START GINGER-MESSAGING NOW!'),
        );
}
