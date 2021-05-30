import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myclinic/screens/auth/login.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../app_constant.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _isLoading;
  final TextEditingController emailController = new TextEditingController();

  void onForgotPasswordPressed(context) async {
    var data = {
      'email': emailController.text,
    };
    var url = Uri.parse(api_url + "/api/password_reset/");
    var response = await http.post(url, body: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      var jsonResponse = json.decode(response.body);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Reset Code has been Sent to Email!"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'pw-reset');
                    },
                    child: Text('Ok'))
              ],
            );
          });
    } else {
      setState(() {
        _isLoading = false;
      });
      showAlertDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()),
                      (Route<dynamic> route) => false);
                },
                child: Container(
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Forgot Passoword',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
            //2nd Part
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
                child: Column(
                  children: <Widget>[
                    //Email
                    TextFormField(
                      controller: emailController,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffe5e5e5),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      onPressed: () => emailController.text == ""
                          ? null
                          : onForgotPasswordPressed(context),
                      color: Color(0xff7f43ff),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff7f43ff),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        padding: EdgeInsets.fromLTRB(135.0, 15.0, 135.0, 15.0),
                        child: Text(
                          'Request',
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    //Cancel
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Invalid"),
      content: Text("Invalid"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
