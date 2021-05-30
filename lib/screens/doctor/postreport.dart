import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myclinic/app_constant.dart';
import 'package:myclinic/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'doctorview.dart';

class PostReport extends StatefulWidget {
  @override
  _PostReportState createState() => _PostReportState();
}

class _PostReportState extends State<PostReport> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  headerSection(),
                  textSection(),
                ],
              ),
      ),
    );
  }

  postReport(String report_details, status, medication_description, response_on,
      response_to, report_by) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      "report_detail": report_details,
      "status": status,
      "medication_description": medication_description,
      "response_on": response_on,
      "response_to": response_to,
      "report_by": report_by
    };
    var jsonResponse = null;
    var url = Uri.parse(api_url + "/appointment/response/");
    var response = await http.post(url, body: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        return Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => DoctorView()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  final TextEditingController reportDetailController =
      new TextEditingController();
  final TextEditingController statusController = new TextEditingController();
  final TextEditingController medicineController = new TextEditingController();
  final TextEditingController responseOnController =
      new TextEditingController();
  final TextEditingController responseToController =
      new TextEditingController();
  final TextEditingController reportByController = new TextEditingController();
  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
            child: Text(
              'Report Details',
              style: TextStyle(fontSize: 15),
            ),
          ),
          TextFormField(
            controller: reportDetailController,
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
              'Status',
              style: TextStyle(fontSize: 15),
            ),
          ),
          TextFormField(
            controller: statusController,
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
              'Medication Description',
              style: TextStyle(fontSize: 15),
            ),
          ),
          TextFormField(
            controller: medicineController,
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
              'Response On',
              style: TextStyle(fontSize: 15),
            ),
          ),
          TextFormField(
            controller: responseOnController,
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
              'Response By',
              style: TextStyle(fontSize: 15),
            ),
          ),
          TextFormField(
            controller: responseToController,
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
              'Response To',
              style: TextStyle(fontSize: 15),
            ),
          ),
          TextFormField(
            controller: reportByController,
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
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff7f43ff),
                  borderRadius: BorderRadius.circular(10.0)),
              width: MediaQuery.of(context).size.width,
              height: 60.0,
              child: Center(
                child: Text(
                  'Post Report',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Text("Post Report",
          style: TextStyle(
              color: Colors.black,
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    );
  }

  postRep() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      "report_detail": reportDetailController.text,
      "status": statusController.text,
      "medication_description": medicineController.text,
      "response_on": responseOnController.text,
      "response_to": responseToController.text,
      "report_by": reportByController.text
    };
    bool filled = true;
    var jsonResponse = null;
    var url = Uri.parse(api_url + "/appointment/response/");
    var response = await http.post(url, body: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        return Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => DoctorView()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }
}
