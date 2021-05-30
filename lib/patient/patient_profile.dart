import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myclinic/app_constant.dart';
import 'package:myclinic/model/pprofilemodels.dart';
import 'package:myclinic/patient/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PProfile extends StatefulWidget {
  @override
  _PProfileState createState() => _PProfileState();
}

class _PProfileState extends State<PProfile> {
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
  void initState() {
    fetchProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey[800],
      ),
      backgroundColor: Colors.blueGrey[800],
      body: FutureBuilder<PatProfile>(
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
                    snapshot.data.firstName + " " + snapshot.data.lastName,
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
                        return Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new EditProfilePatient(
                                  email: snapshot.data.email,
                                  dob: snapshot.data.dob,
                                  gender: snapshot.data.gender_type,
                                )));
                      }),
                  InfoCard(
                      text: (snapshot.data.phone_number).toString(),
                      icon: Icons.phone,
                      onPressed: () async {}),
                  InfoCard(
                      text: snapshot.data.blood_type,
                      icon: Icons.water_damage_outlined,
                      onPressed: () async {}),
                  InfoCard(
                      text: snapshot.data.address,
                      icon: Icons.location_city,
                      onPressed: () async {}),
                  InfoCard(
                      text: snapshot.data.dob,
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
    child: Text(
      "OK",
      style: TextStyle(color: Colors.green),
    ),
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
