import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BlocDemo extends StatefulWidget {
  const BlocDemo({Key? key}) : super(key: key);
  @override
  State<BlocDemo> createState() => BlocDemoState();
}

class BlocDemoState extends State<BlocDemo> {
  bool showPass = false;
  TextEditingController txtUserController = TextEditingController();
  TextEditingController txtPassController = TextEditingController();

  var bloc = LoginBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  void onToggleShowPass() {
    setState(() {
      showPass = !showPass;
    });
  }

  void onSignIn() {
    if (bloc.isValidInfo(txtUserController.text, txtPassController.text)) {
      print('OK');
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            // height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: Container(
                          width: 100,
                          height: 100,
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xffdBdBdB)),
                          child: const FlutterLogo(),
                        )),
                    const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
                        child: Text(
                          'Hello\nWelcome Back',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 30),
                        )),
                    txtUserName(),
                    txtPassword(),
                    btnLogin(),
                    SizedBox(
                      height: 130,
                      width: double.infinity,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'NEW USER? SIGN UP',
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xff888888)),
                            ),
                            Text(
                              'FORGOT PASSWORD?',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.blue),
                            )
                          ]),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Padding btnLogin() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.blue),
            onPressed: () {
              onSignIn();
            },
            child: const Text(
              'SIGN IN',
              style: TextStyle(color: Colors.white, fontSize: 16),
            )),
      ),
    );
  }

  Padding txtPassword() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
      child: Stack(
        children: [
          StreamBuilder(
              stream: bloc.passStream,
              builder: (context, snapshot) {
                return TextField(
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  controller: txtPassController,
                  obscureText: !showPass,
                  decoration: InputDecoration(
                      labelText: 'PASSWORD',
                      errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                      labelStyle: const TextStyle(
                          color: Color(0xff888888), fontSize: 15)),
                );
              }),
          GestureDetector(
            onTap: onToggleShowPass,
            child: Text(
              showPass ? 'HIDE' : 'SHOW',
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
        alignment: AlignmentDirectional.centerEnd,
      ),
    );
  }

  Padding txtUserName() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
      child: StreamBuilder(
          stream: bloc.userStream,
          builder: (context, snapshot) {
            return TextField(
              onChanged: (text) {},
              style: const TextStyle(fontSize: 18, color: Colors.black),
              controller: txtUserController,
              decoration: InputDecoration(
                  labelText: 'USERNAME',
                  errorText:
                      snapshot.hasError ? snapshot.error.toString() : null,
                  labelStyle:
                      const TextStyle(color: Color(0xff888888), fontSize: 15)),
            );
          }),
    );
  }
}

/// Tang xu ly Logic
class LoginBloc {
  StreamController userController = StreamController();
  StreamController passController = StreamController();

  Stream get userStream => userController.stream;
  Stream get passStream => passController.stream;

  bool isValidInfo(String userName, String pass) {
    if (!Validator.isValidUSer(userName)) {
      userController.sink.addError('Tài khoản không hợp lệ');
      return false;
    }
    userController.sink.add('OK');
    if (!Validator.isValidPass(pass)) {
      passController.sink.addError('Mật khẩu không hợp lệ');
      return false;
    }
    passController.sink.add('OK');

    return true;
  }

  void dispose() {
    userController.close();
    passController.close();
  }
}

class Validator {
  static bool isValidUSer(String user) {
    return user.length > 6 && user.contains('@');
  }

  static bool isValidPass(String pass) {
    return pass.length > 6;
  }
}

/// API: DataProvider
class LoginAPI {}

class MyTextField extends TextField {
  const MyTextField({Key? key}) : super(key: key);
  final TextStyle myStyle = const TextStyle(fontSize: 18, color: Colors.black);
  
}
