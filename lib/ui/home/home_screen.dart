import 'package:chat_app/shared_data.dart';
import 'package:chat_app/ui/addRoom/add_room_screen.dart';
import 'package:chat_app/ui/home/home_viewModel.dart';
import 'package:chat_app/ui/home/room_widget.dart';
import 'package:chat_app/ui/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  void initState() {
    super.initState();
    viewModel.loadRooms();
  }

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
                actions: [
                  InkWell(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      SharedData.user = null;
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    child: Icon(Icons.logout),
                  )
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Consumer<HomeViewModel>(
                      builder: (buildContext, homeViewModel, _) {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12),
                          itemBuilder: (_, index) {
                            return RoomWidget(homeViewModel.rooms[index]);
                          },
                          itemCount: homeViewModel.rooms.length,
                        );
                      },
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddRoomScreen.routeName);
                },
                child: Icon(Icons.add),
              ),
            )));
  }
}
