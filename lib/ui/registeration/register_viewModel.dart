import 'package:chat_app/base/base.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterNavigator extends BaseNavigator {}

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  var auth = FirebaseAuth.instance;

  void register(String email, String password) async {
    navigator?.showLoadingDialog();
    try {
      var credentials = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog(credentials.user?.uid ?? '');
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
