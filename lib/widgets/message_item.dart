import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:read_head_chat/models/message.dart';
import 'package:read_head_chat/services/provider.dart';

class MessageItem extends StatelessWidget {
  final Message message;

  MessageItem(this.message);

  @override
  Widget build(BuildContext context) {
    AppProvider _provider = Provider.of<AppProvider>(context);

    DateTime messageTime = DateTime.fromMillisecondsSinceEpoch(message.time);
    DateTime now = DateTime.now();

    bool isMyMessage = message.senderId == _provider.user.id;
    bool isTodayMessage = DateTime(now.day, now.month, now.year) ==
        DateTime(messageTime.day, messageTime.month, messageTime.year);

    String todayTime = DateFormat.Hm().format(messageTime);
    String notTodayTime = DateFormat.Hm().add_yMMM().format(messageTime);

    return Padding(
      padding: const EdgeInsets.only(top: 2.0, right: 10, left: 10),
      child: Row(
          mainAxisAlignment:
              isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: isMyMessage
                    ? LinearGradient(colors: [Colors.green[400], Colors.green])
                    : LinearGradient(colors: [Colors.grey, Colors.blueGrey]),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: isMyMessage ? Radius.circular(15) : Radius.zero,
                    bottomRight:
                        isMyMessage ? Radius.zero : Radius.circular(15)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Text(message.text,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15)),
                  ),
                  _timeText(isTodayMessage ? todayTime : notTodayTime)
                ],
              ),
            ),
          ]),
    );
  }
}

Widget _timeText(time) {
  return Container(
      margin: EdgeInsets.only(left: 4),
      child: Text(
        time,
        style: TextStyle(color: Colors.grey[300], fontSize: 10),
      ));
}
