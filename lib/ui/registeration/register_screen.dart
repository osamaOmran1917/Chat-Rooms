import 'package:chat_app/ui/home/home_screen.dart';
import 'package:chat_app/ui/login/login_screen.dart';
import 'package:chat_app/ui/registeration/register_viewModel.dart';
import 'package:chat_app/validation_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base/base.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'Register Screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen, RegisterViewModel>
    implements RegisterNavigator {
  bool securedPassword = true;
  Widget Eye = Icon(Icons.visibility);
  var formKye = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullNameController = TextEditingController();
  var userNameController = TextEditingController();

  @override
  RegisterViewModel initViewModel() {
    return RegisterViewModel();
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
              title: Text('Create Account'),
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
                          controller: fullNameController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter Full Name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                          ),
                        ),
                        TextFormField(
                          controller: userNameController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter User Name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'User Name',
                          ),
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
                            createAccountClicked();
                          },
                          child: Text(
                            'Create Account',
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.all(12))),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          },
                          child: Text('Already Have Account?'),
                        )
                      ]),
                ),
              ),
            ),
          )),
    );
  }

  var authService = FirebaseAuth.instance;

  void createAccountClicked() {
    if (formKye.currentState?.validate() == false) {
      return;
    }
    viewModel.register(emailController.text, passwordController.text,
        userNameController.text, fullNameController.text);
  }

  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
