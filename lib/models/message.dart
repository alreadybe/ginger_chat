class Message {
  String senderId;
  String text;
  int time;
  bool unread;

  toMap() {
    Map<String, dynamic> result = {
      'senderId': this.senderId,
      'text': this.text,
      'time': this.time,
      'unread': this.unread,
    };

    return result;
  }

  Message.fromMap(map) {
    this.senderId = map['senderId'];
    this.text = map['text'];
    this.time = map['time'];
    this.unread = map['unread'];
  }

  Message({this.senderId, this.text, this.time});
}
