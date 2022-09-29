import 'package:chat_app/base/base.dart';
import 'package:chat_app/data_base/my_database.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/shared_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterNavigator extends BaseNavigator {
  void goToHome();
}

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  var auth = FirebaseAuth.instance;

  void register(String email, String password, userName, fullName) async {
    navigator?.showLoadingDialog();
    try {
      var credentials = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      MyUser newUser = MyUser(
        id: credentials.user?.uid,
        fullName: fullName,
        userName: userName,
        email: email,
      );
      var insertedUser = await MyDataBase.insertUser(newUser);
      navigator?.hideLoadingDialog();
      if (insertedUser != null) {
        SharedData.user = insertedUser;
        navigator?.goToHome();
      } else {
        navigator
            ?.showMessageDialog('Something Went Wrong. Error With DataBase.');
      }
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadingDialog();
      if (e.code == 'weak-password') {
        navigator?.showMessageDialog('The Password Provided Is Too Weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator?.showMessageDialog('E-mail Is Already Registered.');
      }
    } catch (e) {
      navigator?.hideLoadingDialog();
      navigator
          ?.showMessageDialog('Something Went Wrong. Please Try Again Later.');
    }
  }
}
