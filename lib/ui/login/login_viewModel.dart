import 'package:chat_app/base/base.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginNavigator extends BaseNavigator {}

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  var auth = FirebaseAuth.instance;

  void login(String email, String password) async {
    try {
      navigator?.showLoadingDialog();
      var credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog(credential.user?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog('Wrong Username Or Password');
    }
  }
}
