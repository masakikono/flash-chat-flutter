import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:model_progress_hud/model_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpninner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        isAsyncCall: showSpninner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                // InputDecoration(
                //   hintText: 'Enter your email',
                //   contentPadding:
                //       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                //   border: OutlineInputBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(32.0)),
                //   ),
                //   enabledBorder: OutlineInputBorder(
                //     borderSide:
                //         BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                //     borderRadius: BorderRadius.all(Radius.circular(32.0)),
                //   ),
                //   focusedBorder: OutlineInputBorder(
                //     borderSide:
                //         BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                //     borderRadius: BorderRadius.all(Radius.circular(32.0)),
                //   ),
                // ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
                // decoration: InputDecoration(
                //   hintText: 'Enter your password.',
                //   contentPadding:
                //       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                //   border: OutlineInputBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(32.0)),
                //   ),
                //   enabledBorder: OutlineInputBorder(
                //     borderSide:
                //         BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                //     borderRadius: BorderRadius.all(Radius.circular(32.0)),
                //   ),
                //   focusedBorder: OutlineInputBorder(
                //     borderSide:
                //         BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                //     borderRadius: BorderRadius.all(Radius.circular(32.0)),
                //   ),
                // ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  title: 'Log In',
                  colour: Colors.lightBlueAccent,
                  onPressed: () async {
                    setState(() {
                      showSpninner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        showSpninner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
