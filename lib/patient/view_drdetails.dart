import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myclinic/model/pprofilemodels.dart';
import 'package:myclinic/screens/doctor/create_report.dart';
import 'package:myclinic/screens/doctor/videocall.dart';

import '../../app_constant.dart';

class ViewDDetails extends StatefulWidget {
  List list;
  int index;
  ViewDDetails({this.index, this.list});
  @override
  _ViewDDetailsState createState() => _ViewDDetailsState();
}

class _ViewDDetailsState extends State<ViewDDetails> {
  bool enable = true;
  Future<PatProfile> getdata() async {
    var url = Uri.parse(api_url +
        "/users/doctor/${widget.list[widget.index]["appointment"]['doctor']["user"]}");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return PatProfile.fromJson(jsonDecode(response.body));
    } else {
      print((response.body));
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
      ),
      body: FutureBuilder<PatProfile>(
          future: getdata(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Docotr Information",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600)),
                                        SizedBox(height: 20),
                                        Text(
                                          "Mr. " +
                                              snapshot.data.firstName +
                                              " " +
                                              snapshot.data.lastName,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Email: " + snapshot.data.email,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          "Phone:  " +
                                              snapshot.data.phone_number
                                                  .toString(),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          "D.O.B: " + snapshot.data.dob,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          "Gender: " +
                                              snapshot.data.gender_type,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        SizedBox(height: 20),
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundImage: snapshot
                                                      .data.profile_pic ==
                                                  null
                                              ? AssetImage(
                                                  "assets/images/defaultdoctor.png")
                                              : NetworkImage(
                                                  snapshot.data.profile_pic),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            height: 150,
                            width: double.infinity,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.green),
                                        onPressed: () {
                                          if (enable == true) {
                                            Navigator.of(context).push(
                                                new MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        new Meeting(
                                                          index: widget.list[
                                                                  widget.index]
                                                              ['patient'],
                                                          newdata: widget.list[
                                                                  widget.index][
                                                              'appointment_date'],
                                                        )));
                                            setState(() {
                                              enable = false;
                                            });
                                          } else {
                                            return null;
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.video_call),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text("Video Call")
                                          ],
                                        )),
                                    Spacer(),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.green),
                                        onPressed: () {
                                          print(widget.list[widget.index]
                                              ['patient']);
                                          print(
                                              widget.list[widget.index]["id"]);
                                          Navigator.of(context).push(
                                              new MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      new CreateReport(
                                                        ip: widget.list[widget
                                                            .index]['patient'],
                                                        appointment: widget
                                                                .list[
                                                            widget.index]["id"],
                                                      )));
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.note_add),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text("Create Report")
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
