import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myclinic/app_constant.dart';
import 'package:myclinic/model/pprofilemodels.dart';
import 'package:myclinic/patient/patient_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaitentHome extends StatefulWidget {
  @override
  _PaitentHomeState createState() => _PaitentHomeState();
}

class _PaitentHomeState extends State<PaitentHome> {
  Future<PatProfile> fetchProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.get("user_id");
    var url = Uri.parse(api_url + "/users/patient/$userid/");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return PatProfile.fromJson(jsonDecode(response.body));
    } else {
      print((response.body));
      throw Exception("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
          child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: height / 4.5,
              width: width,
              color: Colors.purple,
              child: Padding(
                padding: const EdgeInsets.only(top: 28.0, left: 20),
                child: FutureBuilder<PatProfile>(
                    future: fetchProfile(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return ListTile(
                          leading: Column(
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
                                "Hello" + " " + "loading..",
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return ListTile(
                          leading: Column(
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
                                backgroundImage: snapshot.data.profile_pic == null
                                    ? AssetImage(
                                        "assets/images/defaultdoctor.png")
                                    : NetworkImage(snapshot.data.profile_pic),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return ListTile(
                          leading: Column(
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
                                "Hello" + " " + "loading...",
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        );
                      }
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                margin: EdgeInsets.only(top: 95),
                height: height * 0.9,
                width: width,
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
                          Navigator.of(context).pushNamed("appointments"),
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
                                  Icons.note_add,
                                  size: 90,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Book Appointment",
                                    style: TextStyle(fontSize: 18))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.of(context).pushNamed("booked-appointments"),
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
                      onTap: () => Navigator.of(context).pushNamed('pprofile'),
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
                                Text("My Profile", style: TextStyle(fontSize: 18))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, "doctor-search"),
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
                                  Icons.search_rounded,
                                  size: 90,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Find Doctors", style: TextStyle(fontSize: 18))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed("p-report"),
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
                                  Icons.report,
                                  size: 90,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("My Reports", style: TextStyle(fontSize: 18))
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
    );
  }
}
