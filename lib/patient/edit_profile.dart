import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myclinic/patient/changeprofile.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_constant.dart';

class EditProfilePatient extends StatefulWidget {
  String email;
  String gender;
  String dob;
  EditProfilePatient({this.email, this.gender, this.dob});
  @override
  _EditProfilePatientState createState() => _EditProfilePatientState();
}

class _EditProfilePatientState extends State<EditProfilePatient> {
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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getInt("user_id");
    var token = sharedPreferences.getString("token");
    ProgressDialog progressDialog =
        buildProgressDialog(context, "Validating Data...");
    await progressDialog.show();
    var data = {
      'email': widget.email,
      'phone_number': contactTextEditingController.text.trim(),
      'first_name': firstNameController.text.trim(),
      'last_name': lastnTextEditingController.text.trim(),
      'user_type': "P",
      'address': addressTextEditingController.text.trim(),
      'gender_type': widget.gender,
      'dob': widget.dob
    };
    print(data);
    try {
      var baseurl = Uri.parse(api_url + "/users/register/$id/");
      var response = await http.put(baseurl,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: json.encode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        // jsonResponse = json.decode(response.data);
        await progressDialog.hide();
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Profile Edited"),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'paitenthome');
                      },
                      child: Text('Ok'))
                ],
              );
            });
      }else{
        print(response.body);
        print(response.statusCode);
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
    print(widget.email);
    print(widget.dob);
    print(widget.gender);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const kTextStyle = TextStyle(
        fontFamily: 'Raleway', fontSize: 25.0, fontWeight: FontWeight.bold);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                    SizedBox(height: 20.0),
                    RaisedButton(
                      onPressed: () => firstNameController.text == "" ||
                              lastnTextEditingController.text == "" ||
                              addressTextEditingController.text == "" ||
                              contactTextEditingController.text == ""
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
                          'Edit',
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
