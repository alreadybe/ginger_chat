import 'package:flutter/material.dart';
import 'package:read_head_chat/pages/chat_page.dart';

class ChatItem extends StatelessWidget {
  final String lastMessage;
  final String userName;
  final String chatRoomId;
  final int unreadMessages;

  ChatItem(
      {this.userName, this.lastMessage, this.chatRoomId, this.unreadMessages});

  @override
  Widget build(BuildContext context) {
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
            color: unreadMessages > 0 ? Colors.green : Colors.blueGrey,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
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
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          lastMessage,
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              unreadMessages > 0
                  ? Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Container(
                        child: Text(unreadMessages.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
