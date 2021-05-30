import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myclinic/patient/patient_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../app_constant.dart';

class ChangeProfiel extends StatefulWidget {
  @override
  _ChangeProfielState createState() => _ChangeProfielState();
}

final TextEditingController firstNameController = new TextEditingController();
final TextEditingController lastNameController = new TextEditingController();
final TextEditingController addressController = new TextEditingController();
final TextEditingController dobController = new TextEditingController();
final TextEditingController phoneController = new TextEditingController();

class _ChangeProfielState extends State<ChangeProfiel> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Container(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(children: <Widget>[
                textSection(),
              ]),
      ),
    );
  }

  updateProfile(
    String firstname,
    lastname,
    phone,
    dob,
    address,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      "first_name": firstname,
      "last_name": lastname,
      "phone_number": phone,
      "dob": dob,
      "address": address,
    };
    var jsonResponse = null;
    var userid = sharedPreferences.get("user_id");
    var url = Uri.parse(api_url + "/users/register/$userid/");
    var response = await http.post(url, body: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        return Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => PProfile()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => ChangeProfiel()),
            (Route<dynamic> route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Invalid"),
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

  @override
  // ignore: missing_return
  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
            child: Text(
              'First Name',
              style: TextStyle(fontSize: 15),
            ),
          ),
          TextFormField(
            controller: firstNameController,
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
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
            child: Text(
              'Last Name',
              style: TextStyle(fontSize: 15),
            ),
          ),
          TextFormField(
            controller: lastNameController,
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
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
            child: Text(
              'Phone Number',
              style: TextStyle(fontSize: 15),
            ),
          ),
          TextFormField(
            controller: phoneController,
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
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
            child: Text(
              'Date of Birth',
              style: TextStyle(fontSize: 15),
            ),
          ),
          TextFormField(
            controller: dobController,
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
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
            child: Text(
              'Address',
              style: TextStyle(fontSize: 15),
            ),
          ),
          TextFormField(
            controller: addressController,
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
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60.0,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            margin: EdgeInsets.only(top: 15.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: RaisedButton(
                onPressed: firstNameController.text == "" ||
                        lastNameController.text == "" ||
                        addressController.text == "" ||
                        phoneController.text == "" ||
                        dobController.text == ""
                    ? null
                    : () {
                        setState(() {
                          _isLoading = true;
                        });
                        updateProfile(
                          firstNameController.text,
                          lastNameController.text,
                          addressController.text,
                          phoneController.text,
                          dobController.text,
                        );
                      },
                color: Color(0xff7f43ff),
                child: Text("Update", style: TextStyle(color: Colors.white70)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
