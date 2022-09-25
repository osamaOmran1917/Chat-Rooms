import 'package:chat_app/dialogeUtils.dart';
import 'package:chat_app/validation_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../registeration/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool securedPassword = true;
  Widget Eye = Icon(Icons.visibility);
  var formKye = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
            title: Text('Log In'),
          ),
          body: Container(
            padding: EdgeInsets.all(12),
            child: Form(
              key: formKye,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .25,
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter E-mail Adress';
                          }
                          if (!ValidationUtils.isValidEmail(text)) {
                            return 'Plaese Enter Valid Email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'E-mail Adress',
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter Password';
                          }
                          if (text.length < 6) {
                            return 'Password Should Be At Least 6 Characters';
                          }
                          return null;
                        },
                        obscureText: securedPassword,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                securedPassword = !securedPassword;
                                if (securedPassword)
                                  Eye = Icon(Icons.visibility);
                                else
                                  Eye = Icon(Icons.visibility_off);
                                setState(() {});
                              },
                              child: Eye),
                          labelText: 'Password',
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          signIn();
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(12))),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RegisterScreen.routeName);
                        },
                        child: Text('Create New Account'),
                      )
                    ]),
              ),
            ),
          ),
        ));
  }

  var authService = FirebaseAuth.instance;

  void signIn() {
    if (formKye.currentState?.validate() == false) {
      return;
    }
    showLoading(context, 'Loading...');
    authService
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((userCredential) {
      hideLoading(context);
      showMessage(context, userCredential.user?.uid ?? '');
    }).onError((error, stackTrace) {
      showMessage(context, error.toString());
      hideLoading(context);
    });
  }
}
