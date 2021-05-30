import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myclinic/patient/view_drdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_constant.dart';

class BookedAppointment extends StatefulWidget {
  @override
  _BookedAppointmentState createState() => _BookedAppointmentState();
}

class _BookedAppointmentState extends State<BookedAppointment> {
  Future<List> getappointmentdata() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.get("token");
    var url = Uri.parse(api_url + "/booking/get_treatment/");
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      print("Krisuv Hero");
      print(token);

      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      print("Nabin Zero");
      print(jsonDecode(response.body));
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getappointmentdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: Text("Appointments"),
      ),
      body: FutureBuilder<List>(
          future: getappointmentdata(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data.isEmpty) {
              return CircularProgressIndicator();
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return new Container(
                        height: 500,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black),
                            ),
                            child: ListTile(
                              title: new Text(
                                "Dr." +
                                    " " +
                                    snapshot.data[i]["appointment"]["doctor"]
                                            ["first_name"]
                                        .toString() +
                                    " " +
                                    snapshot.data[i]["appointment"]["doctor"]
                                            ["last_name"]
                                        .toString(),
                                maxLines: 4,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 30),
                              ),
                              // trailing:
                              //     //  GestureDetector(
                              //     //     onTap: () {
                              //     //       Navigator.of(context).push(
                              //     //           new MaterialPageRoute(
                              //     //               builder: (BuildContext context) =>
                              //     //                   new BookAppointment(
                              //     //                     list: snapshot.data,
                              //     //                     index: i,
                              //     //                   )));
                              //     //     },
                              //     //     child:
                              //     new Icon(Icons.arrow_forward_ios),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 35,
                                  ),
                                  new Text(
                                    "Appointment date:" +
                                        " " +
                                        snapshot.data[i]["appointment"]
                                                ["appointment_date"]
                                            .toString(),
                                    maxLines: 4,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                        elevation: 5,
                                        shadowColor: Colors.black,
                                        child: Center(
                                          child: new Text(
                                            "Appointment Details:" +
                                                " \n" +
                                                snapshot.data[i]["appointment"]
                                                        ["appointment_details"]
                                                    .toString(),
                                            textAlign: TextAlign.center,
                                            style: new TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      new Text(
                                        snapshot.data[i]["book"] == true
                                            ? "Booked"
                                            : "Pending",
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  new Text(
                                    "Appointment Fair: " +
                                        " " +
                                        snapshot.data[i]["appointment"]["price"]
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Appointment Status:",
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        new Text(
                                          snapshot.data[i]["book"] == true
                                              ? "Booked"
                                              : "Pending".toString(),
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Card(
                                    color: Colors.green,
                                    elevation: 8,
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              new MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      new ViewDDetails(
                                                        list: snapshot.data,
                                                        index: i,
                                                      )));
                                          
                                        },
                                        child: Text(
                                          "View Details",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }
          }),
    );
  }
}
