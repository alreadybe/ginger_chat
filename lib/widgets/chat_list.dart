import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_head_chat/models/chat.dart';
import 'package:read_head_chat/services/provider.dart';
import 'package:read_head_chat/widgets/chat_item.dart';

class ChatList extends StatelessWidget {
  final Stream<QuerySnapshot> chatsStream;

  ChatList({this.chatsStream});

  @override
  Widget build(BuildContext context) {
    AppProvider _provider = Provider.of<AppProvider>(context);

    String userId = _provider.user.id;
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: StreamBuilder(
            stream: chatsStream,
            builder: (context, snapshot) => snapshot.hasData
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      Chat chatItem =
                          Chat.fromMap(snapshot.data.documents[index].data);
                      print(chatItem.id);
                      if (chatItem.id.indexOf(userId) != -1) {
                        String username = chatItem.users
                            .firstWhere((user) => user.id != userId)
                            .username;
                        return ChatItem(
                          userName: username,
                          lastMessage: chatItem.lastMessageText.length > 0
                              ? chatItem.lastMessageText
                              : '',
                          chatRoomId: chatItem.id,
                          unreadMessages: chatItem.unreadMessages[userId],
                        );
                      }
                      return SizedBox();
                    })
                : Center(child: Text('No chat :('))),
      ),
    );
  }
}
