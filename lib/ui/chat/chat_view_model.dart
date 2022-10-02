import 'package:chat_app/base/base.dart';
import 'package:chat_app/data_base/my_database.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class ChatNavigator extends BaseNavigator {
  void clearMessageText();
}

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  late Room room;

  void send(String messageContent) {
    if (messageContent.trim().isEmpty) {
      navigator?.clearMessageText();
      return;
    }
    var message = Message(
        content: messageContent,
        dateTime: DateTime.now().microsecondsSinceEpoch,
        senderId: SharedData.user?.id,
        senderName: SharedData.user?.userName,
        roomId: room.id);
    MyDataBase.sendMessage(room.id ?? '', message).then((value) {
      navigator?.clearMessageText();
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
          msg: 'Something went wrong, Try again',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black26,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}
