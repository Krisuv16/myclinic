import 'dart:convert';
import 'package:myclinic/app_constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'book_appointment.dart';

class Appointments extends StatefulWidget {
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  Future<List> fetchAppointment() async {
    var url = Uri.parse(api_url + "/appointment/appointment/");
    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAppointment();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointments Available"),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            _specialistsCardInfo(),
          ],
        ),
      ),
    );
  }

  FutureBuilder _specialistsCardInfo() {
    return FutureBuilder<List>(
        future: fetchAppointment(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return CircularProgressIndicator();
          } else {
            return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 290,
                          childAspectRatio: 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext ctx, i) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new BookAppointment(
                                      list: snapshot.data,
                                      index: i,
                                    )));
                          },
                          child: Card(
                            elevation: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 3),
                                CircleAvatar(
                                  backgroundColor: Color(0xFFD9D9D9),
                                  foregroundColor: Colors.white,
                                  backgroundImage: NetworkImage(api_url +
                                      snapshot.data[i]['doctor']
                                          ["profile_pic"]),
                                  radius: 40.0,
                                ),
                                SizedBox(height: 7),
                                Text("Dr." + " " +
                                  snapshot.data[i]['doctor']['first_name'] +
                                      " " +
                                      snapshot.data[i]['doctor']['last_name'],
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                SizedBox(height: 3),
                                Text(
                                    snapshot.data[i]['doctor']
                                            ['specialization'] +
                                        " " +
                                        "Doctor",
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 3),
                                Text(
                                  "About:" +
                                      " " +
                                      snapshot.data[i]['doctor']['about'],
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ));
          }
        });
  }
}
