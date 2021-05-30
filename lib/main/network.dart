  import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:myclinic/model/doctorlists.dart';

import '../app_constant.dart';

List<Dlist> parsePost(String responseBody){
    var list = json.decode(responseBody) as List<dynamic>;
    var posts = list.map((model) => Dlist.fromJson(model)).toList();
    return posts;
  }
  Future<List<Dlist>> fetchAppointment() async {
    var url = Uri.parse(api_url + "/appointment/appointment/");
    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return compute(parsePost, response.body);
    } else {
      throw Exception("Error");
    }
  }