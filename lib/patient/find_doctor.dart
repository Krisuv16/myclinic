import 'dart:convert';
import 'package:myclinic/app_constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'book_appointment.dart';

class SearchDoctor extends StatefulWidget {
  @override
  _SearchDoctorState createState() => _SearchDoctorState();
}

class _SearchDoctorState extends State<SearchDoctor> {
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
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: TextFormField(
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              prefix: Icon(
                Icons.search,
                color: Colors.black,
              ),
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
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              _specialistsCardInfo(),
            ],
          ),
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
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return new Container(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Card(
                          color: Colors.green,
                          elevation: 6,
                          child: ListTile(
                            title: new Text(
                              snapshot.data[i]['doctor']['first_name'] +
                                  ' ' +
                                  snapshot.data[i]['doctor']['last_name'],
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                            trailing: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new BookAppointment(
                                                list: snapshot.data,
                                                index: i,
                                              )));
                                },
                                child: new Icon(Icons.arrow_forward_ios)),
                            leading: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Color(0xFFD9D9D9),
                                  foregroundColor: Colors.white,
                                  backgroundImage: NetworkImage(api_url +
                                      snapshot.data[i]['doctor']
                                          ["profile_pic"]),
                                  radius: 25.0,
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 35,
                                ),
                                new Text(
                                  "Specialization: " +
                                      " " +
                                      snapshot.data[i]['doctor']
                                          ['specialization'],
                                  maxLines: 4,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    new Text(
                                      "About: ",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    new Text(
                                      snapshot.data[i]['doctor']['about'],
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                new Text(
                                  "Price: " +
                                      snapshot.data[i]['doctor']['phone_number']
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }
        });
  }
}
