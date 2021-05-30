import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../app_constant.dart';

class Trying extends StatefulWidget {
  @override
  _TryingState createState() => _TryingState();
}

class _TryingState extends State<Trying> {
  Future<void> getappointemnts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.get("token");
    var url = Uri.parse(api_url + "/booking/appointment-book/");
    var response = await http.get(url ,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print(response.statusCode);
      /* print(response.body); */
    } else {
      print("ERROR");
      print(response.body);
      print(response.statusCode);
    }
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
              
            ],
          ),
        ),
      ),
      
    );
  }
}