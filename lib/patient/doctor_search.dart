import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../app_constant.dart';

class DoctorSearch extends StatefulWidget {
  @override
  _DoctorSearchState createState() => _DoctorSearchState();
}

class _DoctorSearchState extends State<DoctorSearch> {
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Find Doctors"),
          backgroundColor: Colors.blueGrey[800],
        ),
        body: FutureBuilder<List>(
            future: fetchAppointment(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data.isEmpty) {
                return CircularProgressIndicator();
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: snapshot.data.length + 1,
                      itemBuilder: (context, i) {
                        return i == 0 ? _searchBar() :_buildlist(snapshot, i-1);
                      }),
                );
              }
            }));
  }
_searchBar(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      decoration: InputDecoration(
        hintText: "Search.."
      ),
      onChanged: (text){
        text = text.toLowerCase();
        setState(() {
          
        });
      },
    ),
  );
}
  Container _buildlist(AsyncSnapshot<List<dynamic>> snapshot, int i) {
    return Container(
      height: 100,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFFD9D9D9),
                    foregroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        api_url + snapshot.data[i]['doctor']["profile_pic"]),
                    radius: 30.0,
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Dr." +
                        " " +
                        snapshot.data[i]['doctor']['first_name'] +
                        " " +
                        snapshot.data[i]['doctor']['last_name'],
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                      snapshot.data[i]['doctor']['specialization'] +
                          " " +
                          "Doctor",
                      maxLines: 3,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 3),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
