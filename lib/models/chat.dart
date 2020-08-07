import './user.dart';

class Chat {
  String id;
  String lastMessageText;
  String lastMessageSenderId;

  int lastMessageTime;

  Map<String, int> unreadMessages;

  List<User> users;

  toMap() {
    Map<String, dynamic> result = {
      'id': this.id,
      'lastMessageText': this.lastMessageText,
      'users': this.users,
      'unreadMessages': this.unreadMessages,
      'lastMessageTime': this.lastMessageTime,
      'lastMessageSenderId': this.lastMessageSenderId,
    };

    return result;
  }

  Chat.fromMap(map) {
    this.id = map['id'];
    this.lastMessageText = map['lastMessageText'];
    this.lastMessageTime = map['lastMessageTime'];
    this.lastMessageSenderId = map['lastMessageSenderId'];
    this.users = List<User>.from(
        map['users'].map((user) => User.fromMap(user)).toList());
    this.unreadMessages = Map<String, int>.from(map['unreadMessages']);
  }

  Chat({
    this.id,
    this.lastMessageText,
    this.users,
    this.lastMessageTime,
    this.lastMessageSenderId,
    this.unreadMessages,
  });
}
