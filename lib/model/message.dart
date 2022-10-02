class Message {
  static const String collectionName = 'message';
  String? id, content, senderName, senderId, roomId;
  int? dateTime;

  Message(
      {this.id,
      this.content,
      this.senderId,
      this.senderName,
      this.dateTime,
      this.roomId});

  Message.fromFirestore(Map<String, dynamic> data) {
    id = data['id'];
    content = data['content'];
    senderId = data['senderId'];
    senderName = data['senderName'];
    dateTime = data['dateTime'];
    roomId = data['roomId'];
  }

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'content': content,
      'senderId': senderId,
      'senderName': senderName,
      'dateTime': dateTime,
      'roomId': roomId
    };
  }
}
