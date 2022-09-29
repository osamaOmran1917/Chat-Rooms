import 'package:chat_app/base/base.dart';
import 'package:chat_app/data_base/my_database.dart';
import 'package:chat_app/model/room.dart';

abstract class AddRoomNavigator extends BaseNavigator {
  void goBack();
}

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  void addRoom(String title, String desc, String catId) async {
    navigator?.showLoadingDialog(message: 'Creating Room...');
    try {
      var res = await MyDataBase.createRoom(
          Room(title: title, description: desc, catId: catId));
      navigator?.hideLoadingDialog();
      navigator?.goBack();
    } catch (e) {
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog('Something Went Wrong. ${e.toString()}');
    }
  }
}
