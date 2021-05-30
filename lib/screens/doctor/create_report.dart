import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myclinic/model/pprofilemodels.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_constant.dart';

class CreateReport extends StatefulWidget {
  int appointment;
  int ip;
  CreateReport({this.appointment, this.ip});
  @override
  _CreateReportState createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController detailscontroller = new TextEditingController();
  final TextEditingController statuscontroller = new TextEditingController();
  final TextEditingController appointmentscontroller =
      new TextEditingController();
  Future<PatProfile> getdata() async {
    SharedPreferences did = await SharedPreferences.getInstance();
    var url = Uri.parse(api_url + "/users/patient/${widget.ip}");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return PatProfile.fromJson(jsonDecode(response.body));
    } else {
      print((response.body));
      print((response.statusCode));
      throw Exception("Error");
    }
  }

  Future<void> postdata() async {
    SharedPreferences did = await SharedPreferences.getInstance();
    var token = did.get("token");
    var data = {
      "report_detail": detailscontroller.text,
      "status": statuscontroller.text,
      "medication_description": appointmentscontroller.text,
      "response_on": widget.appointment,
      "response_to": widget.ip,
      "report_by": did.getInt("user_id")
    };
    var url = Uri.parse(api_url + "/booking/report/");
    var response = await http.post(url, body: json.encode(data), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return new AlertDialog(
              title: Text("Sucess"),
              actions: [
                FlatButton(
                    color: Colors.green,
                    onPressed: () async {
                      Navigator.of(context).pushNamed("doctor-view");
                    },
                    child: Text(
                      "ok",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            );
          });
      print(response.body);
      print(response.statusCode);
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return new AlertDialog(
              title: Text("Request Error"),
              actions: [
                FlatButton(
                    color: Colors.green,
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "ok",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            );
          });
      print(response.body);
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Create Report"),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () => detailscontroller.text == "" ||
                        statuscontroller.text == "" ||
                        appointmentscontroller.text == ""
                    ? key.currentState.showSnackBar(new SnackBar(
                        content: new Text("Empty Fields"),
                      ))
                    : postdata(),
                child: Text("Send Report")),
            Container(
              width: width,
              child: Column(
                children: [
                  FutureBuilder<PatProfile>(
                    future: getdata(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text("Create Report For Patient Name",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold));
                      } else if (snapshot.hasData || snapshot.data != null) {
                        return Text(
                            "Create Report For" +
                                " " +
                                snapshot.data.firstName +
                                " " +
                                snapshot.data.lastName,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold));
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: detailscontroller,
                      maxLines: 10,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Report Details",
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: statuscontroller,
                      maxLines: 4,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Report Status",
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: appointmentscontroller,
                      cursorColor: Colors.black,
                      maxLines: 10,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Appointment Description",
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
