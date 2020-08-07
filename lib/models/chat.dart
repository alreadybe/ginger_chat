import './user.dart';

class Chat {
  String id;

  int lastSeenDateToUser;
  int lastSeenDateFromUser;

  int lastMessageTime;

  Map<String, int> unreadMessages;

  List<User> users;

  toMap() {
    Map<String, dynamic> result = {
      'id': this.id,
      'lastSeenDateToUser': this.lastSeenDateToUser,
      'lastSeenDateFromUser': this.lastSeenDateFromUser,
      'users': this.users,
      'unreadMessages': this.unreadMessages,
      'lastMessageTime': this.lastMessageTime,
    };

    return result;
  }

  Chat.fromMap(map) {
    this.id = map['id'];
    this.lastSeenDateToUser = map['lastSeenDateToUser'];
    this.lastSeenDateFromUser = map['lastSeenDateFromUser'];
    this.lastMessageTime = map['lastMessageTime'];
    this.users = map['users'];
    this.unreadMessages = map['unreadMessages'];
  }

  Chat({
    this.id,
    this.users,
    this.lastSeenDateToUser,
    this.lastSeenDateFromUser,
    this.lastMessageTime,
    this.unreadMessages,
  });
}
