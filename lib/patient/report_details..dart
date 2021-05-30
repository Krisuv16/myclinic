import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myclinic/app_constant.dart';
import 'package:myclinic/model/doctormodels.dart';
import 'package:myclinic/model/pprofilemodels.dart';
import 'package:http/http.dart' as http;

class ReportDetails extends StatefulWidget {
  List list;
  int index;
  ReportDetails({this.index, this.list});
  @override
  _ReportDetailsState createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  Future<PatProfile> getpdata() async {
    var url = Uri.parse(
        api_url + "/users/patient/${widget.list[widget.index]["response_to"]}");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print("Patient");
      print((response.body));
      print((response.statusCode));
      return PatProfile.fromJson(jsonDecode(response.body));
    } else {
      print((response.body));
      print((response.statusCode));
      throw Exception("Error");
    }
  }

  Future<DocProfile> getddata() async {
    var url = Uri.parse(
        api_url + "/users/doctor/${widget.list[widget.index]["report_by"]}");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print("Doctor");
      print((response.body));
      print((response.statusCode));
      return DocProfile.fromJson(jsonDecode(response.body));
    } else {
      print("error");
      print((response.body));
      print((response.statusCode));
      throw Exception("Error");
    }
  }

  Future<void> getappointment() async {
    var url = Uri.parse(api_url +
        "/booking/get_treatment/${widget.list[widget.index]["report_by"]}");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print("appointment");
      print((response.body));
      print((response.statusCode));
      return jsonDecode(response.body);
    } else {
      print((response.body));
      print((response.statusCode));
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    getpdata();
    getddata();
    getappointment();
    super.initState();
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("My Report"),
          backgroundColor: Colors.blueGrey[800],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          children: [
            FutureBuilder<PatProfile>(
              future: getpdata(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                      height: 150,
                      width: width,
                      child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasData || snapshot.data != null) {
                  return Container(
                    height: 180,
                    width: width,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Paitent Information",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Name:" +
                                      " " +
                                      snapshot.data.firstName +
                                      " " +
                                      snapshot.data.lastName +
                                      " ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Phone:" +
                                      " " +
                                      snapshot.data.phone_number.toString() +
                                      " ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Gender:" +
                                      " " +
                                      snapshot.data.gender_type +
                                      " ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Address:" +
                                      " " +
                                      snapshot.data.address +
                                      " ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Email:" + " " + snapshot.data.email + " ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: snapshot.data.profile_pic ==
                                          null
                                      ? AssetImage(
                                          "assets/images/defaultdoctor.png")
                                      : NetworkImage(snapshot.data.profile_pic),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                      height: 150,
                      width: width,
                      child: Center(child: CircularProgressIndicator()));
                }
              },
            ),
            FutureBuilder<DocProfile>(
              future: getddata(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                      height: 150,
                      width: width,
                      child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasData || snapshot.data != null) {
                  return Container(
                    height: 200,
                    width: width,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Doctor Information",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Name:" +
                                      " " +
                                      snapshot.data.firstName +
                                      " " +
                                      snapshot.data.lastName +
                                      " ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Phone:" +
                                      " " +
                                      snapshot.data.phone_number.toString() +
                                      " ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Gender:" +
                                      " " +
                                      snapshot.data.gender_type +
                                      " ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Address:" +
                                      " " +
                                      snapshot.data.address +
                                      " ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Email:" + " " + snapshot.data.email + " ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Specialization:" +
                                      " " +
                                      snapshot.data.specialization +
                                      " ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: snapshot.data.profile_pic ==
                                          null
                                      ? AssetImage(
                                          "assets/images/defaultdoctor.png")
                                      : NetworkImage(snapshot.data.profile_pic),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                      height: 150,
                      width: width,
                      child: Center(child: CircularProgressIndicator()));
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Patient Report",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: height,
              width: width,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Report Details",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.blue),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.list[widget.index]["report_detail"],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Divider(),
                          Text(
                            "Report Status",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.blue),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.list[widget.index]["status"],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Divider(),
                           Text(
                            "Report Description",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.blue),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.list[widget.index]["medication_description"],maxLines: 25,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
                //     Column(
                //       children: [
                //         SizedBox(
                //           height: 10,
                //         ),
                //         Container(
                //           width: MediaQuery.of(context).size.width,
                //           alignment: Alignment.center,
                //           child: CircleAvatar(
                //             radius: 60,
                //             backgroundImage: api_url +
                //                         widget.list[widget.index]['doctor']
                //                             ['profile_pic'] ==
                //                     null
                //                 ? AssetImage("assets/images/defaultdoctor.png")
                //                 : NetworkImage(api_url +
                //                     widget.list[widget.index]['doctor']['profile_pic']),
                //           ),
                //         ),
                //         SizedBox(
                //           height: 10,
                //         ),
                //         Text(
                //           'Dr. ' +
                //               widget.list[widget.index]['doctor']['first_name'] +
                //               ' ' +
                //               widget.list[widget.index]['doctor']['last_name'],
                //           style: TextStyle(
                //             color: Colors.blueGrey[800],
                //             fontSize: 25,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //         SizedBox(
                //           height: 10,
                //         ),
                //         Text(
                //           "Specialization:" +
                //               " " +
                //               widget.list[widget.index]['doctor']['specialization'],
                //           style: TextStyle(
                //             color: Colors.black,
                //             fontSize: 20,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //         SizedBox(
                //           height: 10,
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Container(
                //             height: 100,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Container(
                //                   width: MediaQuery.of(context).size.width * .5 - 8.0,
                //                   child: Card(
                //                     elevation: 7,
                //                     child: Column(
                //                       mainAxisAlignment: MainAxisAlignment.center,
                //                       children: [
                //                         Text(
                //                           "Appointment Availability",
                //                           style: TextStyle(
                //                               color: Colors.blueGrey[800],
                //                               fontWeight: FontWeight.bold),
                //                         ),
                //                         SizedBox(
                //                           height: 10,
                //                         ),
                //                         Text(
                //                           widget.list[widget.index]['appointment_time'],
                //                           style: TextStyle(
                //                               color: Colors.blueGrey[800],
                //                               fontSize: 20,
                //                               fontWeight: FontWeight.bold),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //                 Container(
                //                   width: MediaQuery.of(context).size.width * .5 - 8.0,
                //                   child: Card(
                //                     elevation: 7,
                //                     child: Column(
                //                       mainAxisAlignment: MainAxisAlignment.center,
                //                       children: [
                //                         Text(
                //                           "Appointment Charge",
                //                           style: TextStyle(
                //                               color: Colors.blueGrey[800],
                //                               fontWeight: FontWeight.bold),
                //                         ),
                //                         SizedBox(
                //                           height: 10,
                //                         ),
                //                         Text(
                //                           "Rs." +
                //                               " " +
                //                               widget.list[widget.index]['price']
                //                                   .toString(),
                //                           style: TextStyle(
                //                               color: Colors.blueGrey[800],
                //                               fontSize: 20,
                //                               fontWeight: FontWeight.bold),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //         Divider(
                //           color: Colors.black,
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Container(
                //             height: 200,
                //             width: MediaQuery.of(context).size.width,
                //             child: Card(
                //               elevation: 4,
                //               child: Column(
                //                 children: [
                //                   SizedBox(
                //                     height: 5,
                //                   ),
                //                   Text(
                //                     'About Doctor',
                //                     style: TextStyle(
                //                       color: Colors.blueGrey[800],
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 20,
                //                     ),
                //                   ),
                //                   SizedBox(
                //                     height: 5,
                //                   ),
                //                   Text(widget.list[widget.index]['doctor']['about'])
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //         Divider(
                //           color: Colors.black,
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Container(
                //             height: 200,
                //             width: MediaQuery.of(context).size.width,
                //             child: Card(
                //               elevation: 4,
                //               child: Column(
                //                 children: [
                //                   SizedBox(
                //                     height: 5,
                //                   ),
                //                   Text(
                //                     'Appointment Details',
                //                     style: TextStyle(
                //                       color: Colors.blueGrey[800],
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 20,
                //                     ),
                //                   ),
                //                   SizedBox(
                //                     height: 5,
                //                   ),
                //                   Text(
                //                       widget.list[widget.index]['appointment_details']),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Divider(
                //             color: Color(0xffd3d3d3),
                //             thickness: 2,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ));
                )));
  }
}
