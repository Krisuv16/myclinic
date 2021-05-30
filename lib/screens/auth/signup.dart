import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myclinic/patient/changeprofile.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../app_constant.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  DateTime date;
  String value;
  List listItem = ["Male", "Female"];
  Future<Null> selectdate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1940),
        lastDate: DateTime(2030));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
        print(
            "${date.year.toString()}-${date.month.toString()}-${date.day.toString()}");
      });
    }
  }

  Dio dio = Dio();
  final TextEditingController emailTextEditingController =
      new TextEditingController();
  final TextEditingController passwordTextEditingController =
      new TextEditingController();
  final TextEditingController firstnTextEditingController =
      new TextEditingController();
  final TextEditingController contactTextEditingController =
      new TextEditingController();
  final TextEditingController addressTextEditingController =
      new TextEditingController();

  final TextEditingController lastnTextEditingController =
      new TextEditingController();
  ProgressDialog buildProgressDialog(context, msg) {
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
        message: msg,
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
        ),
        messageTextStyle: TextStyle(color: Colors.grey));
    return pr;
  }

  void onRegisterPressed(context) async {
    ProgressDialog progressDialog =
        buildProgressDialog(context, "Validating Data...");
    await progressDialog.show();
    var data = {
      'email': emailTextEditingController.text.trim(),
      'password': passwordTextEditingController.text.trim(),
      'phone_number': contactTextEditingController.text.trim(),
      'first_name': firstNameController.text.trim(),
      'last_name': lastnTextEditingController.text.trim(),
      'user_type': "P",
      'address': addressTextEditingController.text.trim(),
      'gender_type': value,
      'dob':
          "${date.year.toString()}-${date.month.toString()}-${date.day.toString()}"
    };
    print(data);
    try {
      var response =
          await dio.post(api_url + "/users/register/", data: json.encode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        // jsonResponse = json.decode(response.data);
        await progressDialog.hide();
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Verification Link Sent to Email!"),
                title: Text("Verification Pending"),
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
      await progressDialog.hide();
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Invalid"),
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
    await progressDialog.hide();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const kRedColour = Color(0xFFA10D0D); //0xFFA10D0D
    const kGreenColour = Color(0xFF11C529);
    const kTextStyle = TextStyle(
        fontFamily: 'Raleway', fontSize: 25.0, fontWeight: FontWeight.bold);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'Register',
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 70.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'First Name',
                          labelStyle: kTextStyle,
                          // hintText: 'EMAIL',
                          // hintStyle: ,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: firstNameController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: kTextStyle,
                          // hintText: 'EMAIL',
                          // hintStyle: ,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: lastnTextEditingController,
                    ),
                    TextField(
                      // controller: email,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: kTextStyle,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: emailTextEditingController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: kTextStyle,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: passwordTextEditingController,
                      obscureText: true,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: kTextStyle,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: contactTextEditingController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: kTextStyle,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: addressTextEditingController,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // width: width,
                        child: Row(
                          children: [
                            Text(
                              "Pick DOB:   ",
                              style: TextStyle(fontSize: 25),
                            ),
                            GestureDetector(
                                onTap: () {
                                  selectdate(context);
                                  print("test");
                                },
                                child: Icon(Icons.date_range))
                          ],
                        ),
                      ),
                    ),
                    DropdownButton(
                      hint: Text("Gender"),
                      // dropdownColor: Colors.amber,
                      value: value,
                      items: listItem.map((valueitem) {
                        return DropdownMenuItem(
                            value: valueitem, child: Text(valueitem));
                      }).toList(),
                      onChanged: (newvalue) {
                        setState(() {
                          value = newvalue;
                          print(value);
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      onPressed: () => emailTextEditingController.text == "" ||
                              passwordTextEditingController.text == "" ||
                              firstNameController.text == "" ||
                              lastnTextEditingController.text == "" ||
                              addressTextEditingController.text == "" ||
                              contactTextEditingController.text == "" ||
                              date == null ||
                              value == null
                          ? null
                          : onRegisterPressed(context),
                      // Navigator.of(context).pushNamed('/profile');
                      color: Colors.green,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        padding: EdgeInsets.fromLTRB(110.0, 15.0, 110.0, 15.0),
                        child: Text(
                          'Sign up',
                          style: kTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
