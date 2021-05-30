import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myclinic/model/doctormodels.dart';
import 'package:myclinic/patient/patient_profile.dart';
import 'package:myclinic/screens/doctor/videocall.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_constant.dart';

class DoctorView extends StatefulWidget {
  @override
  _DoctorViewState createState() => _DoctorViewState();
}

class _DoctorViewState extends State<DoctorView> {
  Future<DocProfile> fetchProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.get("user_id");
    var url = Uri.parse(api_url + "/users/doctor/$userid/");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return DocProfile.fromJson(jsonDecode(response.body));
    } else {
      print((response.body));
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    fetchProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
          child: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          elevation: .1,
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              FutureBuilder<DocProfile>(
                future: fetchProfile(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Text(
                                  'Loading...',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome to MyClinic",
                                  style: TextStyle(
                                      fontSize: 25, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  "Greetings" +
                                      " " +
                                      "Dr." +
                                      snapshot.data.firstName +
                                      " " +
                                      snapshot.data.lastName +
                                      " " +
                                      "!",
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                            trailing: Column(
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
                            ),
                          ),
                        ),
                      ),
                    );
                  }else{
                    return CircularProgressIndicator();
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _notificationCard(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.extent(
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    padding: const EdgeInsets.all(8),
                    crossAxisSpacing: 10,
                    // mainAxisSpacing: 7,
                    maxCrossAxisExtent: 200.0,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () =>
                        Navigator.of(context).pushNamed("dappointments"),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.note,
                                    size: 90,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("My Appointments",
                                      style: TextStyle(fontSize: 18))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed('dprofile'),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.account_box_rounded,
                                    size: 90,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("My Profile",
                                      style: TextStyle(fontSize: 18))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.remove("user_id");
                          sharedPreferences.remove("token");
                          sharedPreferences.remove("user_type");
                          print(sharedPreferences.get("user_id"));
                          showAlertDialog(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.logout,
                                    size: 90,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Logout", style: TextStyle(fontSize: 18))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _greetings() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Text(
                  'Dr, Doctor One',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),
                Spacer(),
                Container(
                    height: 70,
                    width: 70,
                    child: Image(
                        image: AssetImage("assets/images/defaultdoctor.png")))
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
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
          'Your Appointment with \nPatient Nabin',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: OutlineButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => Meeting()),
            );
          },
          color: Colors.transparent,
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          child: Text(
            'Make Call',
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
}
