import 'package:chat_app/base/base.dart';
import 'package:chat_app/data_base/my_database.dart';
import 'package:chat_app/model/room.dart';

abstract class HomeNavigator extends BaseNavigator {}

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  List<Room> rooms = [];

  void loadRooms() async {
    rooms = await MyDataBase.loadRooms();
    notifyListeners();
  }
}
