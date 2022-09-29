import 'package:chat_app/ui/addRoom/add_room_screen.dart';
import 'package:chat_app/ui/home/home_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base/base.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }

  @override
  Widget build(BuildContext context) {
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
                title: Text('Chat App'),
              ),
              body: Container(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddRoomScreen.routeName);
                },
                child: Icon(Icons.add),
              ),
            )));
  }
}
