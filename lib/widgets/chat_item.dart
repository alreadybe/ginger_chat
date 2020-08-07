import 'package:flutter/material.dart';
import 'package:read_head_chat/pages/chat_page.dart';

class ChatItem extends StatelessWidget {
  final lastMessage;
  final userName;
  final chatRoomId;

  ChatItem({this.userName, this.lastMessage, this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    print(chatRoomId);

    return Padding(
      padding: EdgeInsets.only(top: 10, right: 10, left: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  chatRoomId: chatRoomId,
                  username: userName,
                ),
              ));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: 60,
                  height: 60,
                  child: Image.asset(
                    'assets/images/chat_image.png',
                  )),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(lastMessage),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
