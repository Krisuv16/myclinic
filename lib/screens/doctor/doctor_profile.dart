import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myclinic/model/doctormodels.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../app_constant.dart';

class DoctorProfile extends StatefulWidget {
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
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

  // FlatButton flatButton() {
  //   return FlatButton(
  //       onPressed: () {
  //         return Navigator.of(context).pushAndRemoveUntil(
  //             MaterialPageRoute(
  //                 builder: (BuildContext context) => ChangeProfiel()),
  //             (Route<dynamic> route) => false);
  //       },
  //       child: Text(
  //         "Update Profile",
  //         style: TextStyle(
  //           color: Colors.black,
  //           fontSize: 14.0,
  //         ),
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey[800],
      ),
      backgroundColor: Colors.blueGrey[800],
      body: FutureBuilder<DocProfile>(
        future: fetchProfile(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(snapshot.data.profile_pic),
                  ),
                  Text(
                    "Dr." + snapshot.data.firstName + " " + snapshot.data.lastName,
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Pacifico",
                    ),
                  ),
                  Text(
                    snapshot.data.email,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey[200],
                        fontFamily: "Source Sans Pro"),
                  ),
                  SizedBox(
                    height: 20,
                    width: 200,
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),
                  InfoCard(
                      text: "Update Profile",
                      icon: Icons.edit,
                      onPressed: () async {
                        return Navigator.of(context).pushNamed("editprofile");
                      }),
                  InfoCard(
                      text: snapshot.data.phone_number.toString(),
                      icon: Icons.phone,
                      onPressed: () async {}),
                  InfoCard(
                      text: "Specialization:" + " "+snapshot.data.specialization,
                      icon: Icons.domain_verification_sharp,
                      onPressed: () async {}),
                  InfoCard(
                      text: "Gender:" + " "+snapshot.data.gender_type,
                      icon: Icons.account_box,
                      onPressed: () async {}),
                  InfoCard(
                      text: "DOB:" + " "+snapshot.data.dob,
                      icon: Icons.calendar_today,
                      onPressed: () async {}),
                  InfoCard(
                      text: "Logout",
                      icon: Icons.logout,
                      onPressed: () async {
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.remove("user_id");
                        sharedPreferences.remove("token");
                        sharedPreferences.remove("user_type");
                        print(sharedPreferences.get("user_id"));
                        showAlertDialog(context);
                      }),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget okButton = FlatButton(
    child: Text("OK",style: TextStyle(color: Colors.green),),
    onPressed: () {
      Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Logout"),
    content: Text("Do you want to logout?"),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class InfoCard extends StatelessWidget {
  // the values we need
  final String text;
  final IconData icon;
  Function onPressed;

  InfoCard(
      {@required this.text, @required this.icon, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.teal,
          ),
          title: Text(
            text,
            style: TextStyle(
                color: Colors.teal,
                fontSize: 20,
                fontFamily: "Source Sans Pro"),
          ),
        ),
      ),
    );
  }
}
