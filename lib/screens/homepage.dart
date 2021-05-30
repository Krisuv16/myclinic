import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Future getdata() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () async {
                // SharedPreferences sharedPreferences =
                //     await SharedPreferences.getInstance();
                // Navigator.pushNamedAndRemoveUntil(
                //     context, "login", (route) => false);
              })
        ],
      ),
    );
  }
}
