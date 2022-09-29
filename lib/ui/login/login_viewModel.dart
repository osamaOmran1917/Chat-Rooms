import 'package:chat_app/base/base.dart';
import 'package:chat_app/data_base/my_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../shared_data.dart';

abstract class LoginNavigator extends BaseNavigator {
  void goToHome();
}

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  var auth = FirebaseAuth.instance;

  void login(String email, String password) async {
    try {
      navigator?.showLoadingDialog();
      var credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      var retrievedUser =
          await MyDataBase.getUserById(credential.user?.uid ?? '');
      navigator?.hideLoadingDialog();
      if (retrievedUser == null) {
        navigator?.showMessageDialog('Wrong User Name Or Password');
      } else {
        SharedData.user = retrievedUser;
        navigator?.goToHome();
      }
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog('Wrong Username Or Password');
    }
  }
}
