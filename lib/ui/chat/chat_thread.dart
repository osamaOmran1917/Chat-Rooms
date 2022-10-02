import 'package:chat_app/base/base.dart';
import 'package:chat_app/data_base/my_database.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/ui/chat/chat_view_model.dart';
import 'package:chat_app/ui/chat/message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatThread extends StatefulWidget {
  static const String routeName = 'Chat Thread';

  @override
  State<ChatThread> createState() => _ChatThreadState();
}

class _ChatThreadState extends BaseState<ChatThread, ChatViewModel>
    implements ChatNavigator {
  late Room room;
  var messageController = TextEditingController();

  @override
  ChatViewModel initViewModel() {
    return ChatViewModel();
  }

  @override
  void clearMessageText() {
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    room = ModalRoute.of(context)?.settings.arguments as Room;
    viewModel.room = room;
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage('assets/images/background_pattern.png'),
                  fit: BoxFit.fill)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text('${room.title}'),
            ),
            body: Card(
              margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              elevation: 18,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Expanded(
                      child: StreamBuilder<QuerySnapshot<Message>>(
                    stream: MyDataBase.getMessageCollection(room.id ?? '')
                        .orderBy('dateTime', descending: true)
                        .snapshots(),
                    builder: (buildContext, asyncSnapshot) {
                      if (asyncSnapshot.hasError) {
                        return Center(
                          child: Text('Something Went Wrong. Try Again'),
                        );
                      } else if (asyncSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var data = asyncSnapshot.data?.docs
                          .map((doc) => doc.data())
                          .toList();
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                          reverse: true,
                          separatorBuilder: (_, __) {
                            return SizedBox(
                              height: 8,
                            );
                          },
                          itemBuilder: (buildContext, index) {
                            return MessageWidget(data![index]);
                          },
                          itemCount: data?.length ?? 0,
                        ),
                      );
                    },
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black26),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12))),
                            child: TextField(
                              controller: messageController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(4),
                                  hintText: 'message'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        InkWell(
                          onTap: () {
                            viewModel.send(messageController.text);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).primaryColor),
                            child: Row(
                              children: [
                                Text(
                                  'send',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.send,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
