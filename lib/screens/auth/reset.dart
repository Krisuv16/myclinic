import 'package:flutter/material.dart';
import 'package:myclinic/screens/auth/login.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import '../../app_constant.dart';
import 'forgot.dart';

class ResetPasswordToken extends StatefulWidget {
  @override
  _ResetPasswordTokenState createState() => _ResetPasswordTokenState();
}

class _ResetPasswordTokenState extends State<ResetPasswordToken> {
  final TextEditingController passwordcontroller = new TextEditingController();
  final TextEditingController tokencontroller = new TextEditingController();
  void resetpassword(context) async {
    // ProgressDialog progressDialog =
        // buildProgressDialog(context, "Validating Data..");
    // await progressDialog.show();
    var data = {
      'token': tokencontroller.text,
      'password': passwordcontroller.text,
    };
    var jsonResponse = null;
    try {
      var url = Uri.parse(api_url + "/api/password_reset/confirm/");
      var response = await http.post(url, body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        // jsonResponse = json.decode(response.data);
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Password Reset Sucessful"),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'login');
                      },
                      child: Text('Ok'))
                ],
              );
            });
      }
    } catch (e) {
      print(e);
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Invalid"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
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
                      'Reset Passoword',
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
                        controller: tokencontroller,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Enter Token",
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
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: passwordcontroller,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Enter New-Password",
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
                        onPressed: () => resetpassword(context),
                        color: Color(0xff7f43ff),
                        textColor: Colors.white,
                        padding: EdgeInsets.all(0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff7f43ff),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          padding:
                              EdgeInsets.fromLTRB(135.0, 15.0, 135.0, 15.0),
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
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Success"),
    content: Text("Password Reset Successfully!"),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
