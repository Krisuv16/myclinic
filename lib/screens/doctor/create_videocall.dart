import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateVideoCall extends StatefulWidget {
  int index;
  CreateVideoCall({this.index});
  @override
  _CreateVideoCallState createState() => _CreateVideoCallState();
}

class _CreateVideoCallState extends State<CreateVideoCall> {
  Future sendvdocall() async {
    SharedPreferences pid = await SharedPreferences.getInstance();
    var token = pid.get("token");
    var id = pid.getInt("id");
    var data = {
      "doctor_id": pid.getInt("user_id"),
      "start_time": "xxx",
      "patient_id": "${widget.index}"
    };
    print(data);
  }

  @override
  void initState() {
    sendvdocall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
