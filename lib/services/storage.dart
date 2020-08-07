import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:read_head_chat/models/chat.dart';
import 'package:read_head_chat/models/user.dart';

class Storage {
  Future getUserByUsername(username) async {
    QuerySnapshot user = await Firestore.instance
        .collection('users')
        .where('username',
            isGreaterThanOrEqualTo: username, isLessThanOrEqualTo: username)
        .getDocuments()
        .catchError((e) => print(e.toString()));
    if (user.documents.length > 0) {
      return User(
          id: user.documents[0].data['id'],
          email: user.documents[0].data['email'],
          username: user.documents[0].data['username']);
    }
  }

  Future getUserById(id) async {
    QuerySnapshot user = await Firestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .getDocuments()
        .catchError((e) => print(e.toString()));
    if (user.documents.length > 0) {
      return User(
          id: user.documents[0].data['id'],
          email: user.documents[0].data['email'],
          username: user.documents[0].data['username']);
    }
  }

  Future getUserByEmail(email) async {
    QuerySnapshot user = await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .getDocuments()
        .catchError((e) => print(e.toString()));

    if (user.documents.length > 0) {
      return User(
          id: user.documents[0].data['id'],
          email: user.documents[0].data['email'],
          username: user.documents[0].data['username']);
    }
  }

  void uploadUser(userData, username) async {
    Map<String, String> user = {
      'id': userData.id,
      'email': userData.email,
      'username': username,
    };
    await Firestore.instance
        .collection('users')
        .add(user)
        .catchError((e) => print(e.toString()));
  }

  Future getOrCreateChatRoom(User fromUser, User toUser) async {
    Firestore firestore = Firestore.instance;

    String chatRoomId = '${fromUser.id}_${toUser.id}';

    QuerySnapshot chat = await firestore
        .collection('chatrooms')
        .where('id', isEqualTo: chatRoomId)
        .getDocuments();

    if (chat.documents.length == 0) {
      List<Map> users = [fromUser.toMap(), toUser.toMap()];

      Map<String, dynamic> chatRoomData = {
        'id': chatRoomId,
        'users': users,
        'lastSeenDateFromUser': DateTime.now().millisecondsSinceEpoch,
        'lastSeenDateToUser': '',
        'lastMessageTime': '',
        'unreadMessages': {'${fromUser.id}': 0, '${toUser.id}': 0}
      };

      await firestore
          .collection('chatrooms')
          .document(chatRoomId)
          .setData(chatRoomData)
          .catchError((e) => print('Error create chat: ${e.toString()}'));

      chat = await firestore
          .collection('chatrooms')
          .where('id', isEqualTo: chatRoomId)
          .getDocuments();
    }

    List<dynamic> rawUsers = chat.documents[0].data['users'];
    List<User> users = [User.fromMap(rawUsers[0]), User.fromMap(rawUsers[1])];

    return Chat(
      id: chat.documents[0].data['id'],
      users: users,
      lastSeenDateFromUser: chat.documents[0].data['lastSeenDateFromUser'],
      lastSeenDateToUser: chat.documents[0].data['lastSeenDateToUser'],
      lastMessageTime: chat.documents[0].data['lastMessageTime'],
      unreadMessages: chat.documents[0].data['unreadMessages'],
    );
  }

  Future getChatsList(userId) async {
    Firestore firestore = Firestore.instance;

    Stream<QuerySnapshot> chatsList = firestore
        .collection('chatrooms')
        .where('id',
            isGreaterThanOrEqualTo: userId, isLessThanOrEqualTo: userId)
        .orderBy('lastMessageTime', descending: false)
        .snapshots();

    return chatsList;
  }

  Future getConversations(chatRoomId) async {
    Firestore firestore = Firestore.instance;

    Stream<QuerySnapshot> messagesStream = firestore
        .collection('chatrooms')
        .document(chatRoomId)
        .collection('messages')
        .orderBy('time', descending: false)
        .snapshots();

    return messagesStream;
  }

  void updateUnreadCounter(fromId, chatRoomId) async {
    Firestore firestore = Firestore.instance;

    Map<String, dynamic> oldUnreadMessages = await firestore
        .collection('chatrooms')
        .document(chatRoomId)
        .get()
        .then((chat) => chat.data != null
            ? Map<String, dynamic>.from(chat.data['unreadMessages'])
            : []);

    String toId =
        oldUnreadMessages.keys.firstWhere((element) => element != fromId);

    Map<String, dynamic> newUnreadMessages = {
      fromId: 0,
      toId: oldUnreadMessages[toId] + 1,
    };

    await firestore
        .collection('chatrooms')
        .document(chatRoomId)
        .updateData({'unreadMessages': newUnreadMessages});
  }

  void sendMessage(chatRoomId, text, senderId) async {
    Firestore firestore = Firestore.instance;

    int time = DateTime.now().millisecondsSinceEpoch;

    Map<String, dynamic> message = {
      'senderId': senderId,
      'text': text,
      'time': time,
    };

    await firestore
        .collection('chatrooms')
        .document(chatRoomId)
        .collection('messages')
        .add(message);

    await firestore
        .collection('chatrooms')
        .document(chatRoomId)
        .updateData({'lastMessageTime': time});
  }
}
