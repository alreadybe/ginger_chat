import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:read_head_chat/services/auth.dart';
import 'package:read_head_chat/services/prefs.dart';
import 'package:read_head_chat/services/provider.dart';
import 'package:read_head_chat/services/storage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  Auth _auth = Auth();
  Prefs _prefs = Prefs();
  Storage _storage = Storage();

  TextEditingController usernameController;
  TextEditingController emailController;
  TextEditingController passwordController;

  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex;

  @override
  void initState() {
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    regex = RegExp(pattern);

    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _provider = Provider.of<AppProvider>(context);

    void _handleSignIn() {
      _auth.signIn(emailController.text, passwordController.text).then((value) {
        if (value != null) {
          _storage.getUserByEmail(emailController.text).then((user) {
            if (user != null) {
              _provider.setUser(user, null);
              _prefs.saveLogin(user.id);
            }
          });

          Navigator.pushReplacementNamed(context, '/home');
        } else {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg: "This ginger-user doesn't exist, don't be fooled",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Theme.of(context).primaryColor,
              textColor: Theme.of(context).accentColor,
              fontSize: 14.0);
        }
      });
    }

    void _handleSignUp() {
      _auth.signUp(emailController.text, passwordController.text).then((value) {
        if (value != null) {
          _provider.setUser(value, usernameController.text);
          _prefs.saveLogin(value.id);
          _storage.uploadUser(value, usernameController.text);
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg:
                  "You are already in the ginger-app, why are you doing it again?",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Theme.of(context).primaryColor,
              textColor: Theme.of(context).accentColor,
              fontSize: 14.0);
        }
      });
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).accentColor,
      body: SafeArea(
        child: isLoading
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: Container(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 20.0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Image(
                                image: AssetImage('assets/images/logo.png'),
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          Text('Ginger Chat',
                              style: TextStyle(
                                  fontSize: 35,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 30.0),
                        child: Container(
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                _provider.signup
                                    ? TextFormField(
                                        controller: usernameController,
                                        validator: (val) {
                                          return (val.isEmpty ||
                                                      val.length < 3) &&
                                                  _provider.signup
                                              ? 'Ginger-name.length > 3'
                                              : null;
                                        },
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor),
                                        cursorColor: Colors.white,
                                        decoration: InputDecoration(
                                            hintText: 'Username',
                                            fillColor:
                                                Theme.of(context).primaryColor,
                                            filled: true,
                                            border: InputBorder.none),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) {
                                    return (regex.hasMatch(val))
                                        ? null
                                        : "Hmmm... Email isn't ginger enough, fix it";
                                  },
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor),
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                      hintText: 'Email',
                                      fillColor: Theme.of(context).primaryColor,
                                      filled: true,
                                      border: InputBorder.none),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  validator: (val) {
                                    return val.isEmpty || val.length < 6
                                        ? 'Need more symbols to your ginger-password'
                                        : null;
                                  },
                                  obscureText: true,
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor),
                                  keyboardType: TextInputType.visiblePassword,
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                      hintText: 'Password',
                                      fillColor: Theme.of(context).primaryColor,
                                      filled: true,
                                      border: InputBorder.none),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: FlatButton(
                                    child: Text(
                                      'Reset password',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () => {},
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              width: 160,
                              height: 50,
                              child: RaisedButton(
                                elevation: 0,
                                color: Theme.of(context).primaryColor,
                                child: Text(
                                  _provider.signup
                                      ? 'Sign Up'.toUpperCase()
                                      : 'Sign In'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    if (_provider.signup) {
                                      _handleSignUp();
                                    } else {
                                      _handleSignIn();
                                    }
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 150,
                              height: 40,
                              child: RaisedButton(
                                elevation: 0,
                                color: Colors.white,
                                child: Text(
                                  _provider.signup
                                      ? 'Sign In'.toUpperCase()
                                      : 'Sign Up'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                                onPressed: () {
                                  _provider.toggleAuth();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
