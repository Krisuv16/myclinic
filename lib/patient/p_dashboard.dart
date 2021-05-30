import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myclinic/app_constant.dart';

import 'book_appointment.dart';

class PatientDashboard extends StatefulWidget {
  @override
  _PatientDashboardState createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  Future<List> fetchDoctors() async {
    var url = Uri.parse(api_url + "/users/doctor/");
    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              _greetings(),
              _nextAppointmentText(),
              _appoinmentCard(),
              // _notificationCard(),
              _areaSpecialistsText(),
              _specialistsCardInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Container _backBgCover() {
    return Container(
      height: 260.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
    );
  }

  Column _greetings() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Hi Nabin Khanal',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w500,
            color: Colors.green,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'How are you feeling today ?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _nextAppointmentText() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Choose Your Problem Area',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Text(
            'See All',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Container _appoinmentCard() {
    return Container(
      height: 200,
      width: 400,
      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: FutureBuilder<List>(
          future: fetchDoctors(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data.isEmpty) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 300,
                      width: 350,
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Color(0xFFD9D9D9),
                                  foregroundColor: Colors.white,
                                  backgroundImage:
                                      snapshot.data[i]["profile_pic"] == null
                                          ? AssetImage("assets/images/logo.png")
                                          : NetworkImage(
                                              snapshot.data[i]["profile_pic"]),
                                  radius: 36.0,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: snapshot.data[i]['specialization'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5,
                                    ),
                                    children: <TextSpan>[],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Divider(
                              color: Colors.grey[200],
                              height: 3,
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }

  Column _iconBuilder(icon, title) {
    return Column(
      children: <Widget>[
        Icon(
          icon,
          size: 28,
          color: Colors.black,
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Container _notificationCard() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFBF4954),
        // gradient: redGradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          Icons.ac_unit,
          color: Colors.white,
          size: 32,
        ),
        title: Text(
          'Your Appointment with \nDr Kyecera',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: OutlineButton(
          onPressed: () {},
          color: Colors.transparent,
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          child: Text(
            'Review & Add Notes',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _areaSpecialistsText() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Doctors',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Text(
            'See All',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder _specialistsCardInfo() {
    return FutureBuilder<List>(
        future: fetchDoctors(),
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
                      height: 180,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          height: 10,
                          child: Card(
                            color: Color(0xff7f43ff),
                            elevation: 6,
                            child: ListTile(
                              title: new Text(
                                snapshot.data[i]['first_name'] +
                                    ' ' +
                                    snapshot.data[i]['last_name'],
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
                                    backgroundImage: NetworkImage(
                                        snapshot.data[i]["profile_pic"]),
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
                                        snapshot.data[i]['specialization'],
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
                                        snapshot.data[i]['about'],
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  new Text(
                                    "Phone Number: " +
                                        snapshot.data[i]['phone_number']
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                ],
                              ),
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
