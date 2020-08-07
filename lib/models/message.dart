class Message {
  String senderId;
  String senderName;
  String text;
  int time;
  bool unread;

  toMap() {
    Map<String, dynamic> result = {
      'senderId': this.senderId,
      'senderName': this.senderName,
      'text': this.text,
      'time': this.time,
      'unread': this.unread,
    };

    return result;
  }

  Message.fromMap(map) {
    this.senderId = map['senderId'];
    this.senderName = map['senderName'];
    this.text = map['text'];
    this.time = map['time'];
    this.unread = map['unread'];
  }

  Message({this.senderId, this.senderName, this.text, this.time});
}
