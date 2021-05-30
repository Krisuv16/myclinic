import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myclinic/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BookAppointment extends StatefulWidget {
  List list;
  int index;
  BookAppointment({this.index, this.list});
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  var aid;
  var fid;
  String myTest;
  DateTime date = DateTime.now();
  TimeOfDay time;
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

  Future<void> postdata() async {
    SharedPreferences pid = await SharedPreferences.getInstance();
    var token = pid.get("token");
    var data = {
      "appointment_id": aid,
      "patient": pid.getInt("user_id"),
      "appointment_date":
          "${date.year.toString()}-${date.month.toString()}-${date.day.toString()}"
    };
    print(data);
    var url = Uri.parse(api_url + "/booking/appointment-book/");
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
              title: Text("Confirmation Pending"),
              actions: [
                FlatButton(
                    color: Colors.green,
                    onPressed: () async {
                      Navigator.of(context).pushNamed("paitenthome");
                    },
                    child: Text(
                      "ok",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            );
          });
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
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Book Appointment"),
          backgroundColor: Colors.blueGrey[800],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: api_url +
                                widget.list[widget.index]['doctor']
                                    ['profile_pic'] ==
                            null
                        ? AssetImage("assets/images/defaultdoctor.png")
                        : NetworkImage(api_url +
                            widget.list[widget.index]['doctor']['profile_pic']),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Dr. ' +
                      widget.list[widget.index]['doctor']['first_name'] +
                      ' ' +
                      widget.list[widget.index]['doctor']['last_name'],
                  style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Specialization:" +
                      " " +
                      widget.list[widget.index]['doctor']['specialization'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .5 - 8.0,
                          child: Card(
                            elevation: 7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Appointment Availability",
                                  style: TextStyle(
                                      color: Colors.blueGrey[800],
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget.list[widget.index]['appointment_time'],
                                  style: TextStyle(
                                      color: Colors.blueGrey[800],
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .5 - 8.0,
                          child: Card(
                            elevation: 7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Appointment Charge",
                                  style: TextStyle(
                                      color: Colors.blueGrey[800],
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Rs." +
                                      " " +
                                      widget.list[widget.index]['price']
                                          .toString(),
                                  style: TextStyle(
                                      color: Colors.blueGrey[800],
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 4,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'About Doctor',
                            style: TextStyle(
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(widget.list[widget.index]['doctor']['about'])
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 4,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Appointment Details',
                            style: TextStyle(
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              widget.list[widget.index]['appointment_details']),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Color(0xffd3d3d3),
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Text(
                          "Pick Date:   ",
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blueGrey[800],
                    ),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 60.0,
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    margin: EdgeInsets.only(top: 15.0),
                    child: TextButton(
                      onPressed: () async => date == null
                          ? null
                          : showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return new AlertDialog(
                                  title: Text("Request Appointment"),
                                  content: Text(
                                      "Do you want to Request this Appointment ?"),
                                  actions: [
                                    FlatButton(
                                        color: Colors.green,
                                        onPressed: () async {
                                          setState(() {
                                            aid = widget.list[widget.index]
                                                ["doctor"]["user"];
                                            print(aid);
                                          });
                                          SharedPreferences pid =
                                              await SharedPreferences
                                                  .getInstance();
                                          pid.getInt("user_id");
                                          print(pid.getInt("user_id"));
                                          postdata();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    FlatButton(
                                        color: Colors.red,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.white),
                                        ))
                                  ],
                                );
                              }),
                      child: Text("Request Appointment",
                          style: TextStyle(color: Colors.white70)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
