import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temutemu/models/Events.dart';

class EventSession {
  static final String host = productionHost;
  static final String productionHost = 'http://temutemu.herokuapp.com/event';
  // static String getToken(SharedPreferences prefs) {
  //   var authTokenKey;
  //   return prefs.getString(authTokenKey);
  // }

  Future<Map> eventPost(String authTokenKey, Map data) async {
    var responseBody = json.decode('{"data": "", "status": "NOK"}');
    try {
      debugPrint("MASUK NIH YA : $authTokenKey");
       debugPrint("MASUK NIH YA map : $data");
      var response = await http.post(host,
          body: json.encode(data),
          headers: {
             'authorization' : 'bearer $authTokenKey',
            'content-type': 'application/json'
          });

      if (response.statusCode == 200) {
        responseBody = response.body;
      }
    } catch (e) {
      throw new Exception("AJAX error");
    }
    return responseBody;
    // return await http.post(host, body: json.encode(body), headers: {
    //   HttpHeaders.authorizationHeader: authTokenKey
    // }).then((http.Response response) {
    //   final int statusCode = response.statusCode;

    //   if (statusCode < 200 || statusCode > 400 || json == null) {
    //     throw new Exception("Error while fetching data");
    //   }
    //   return Events.fromJson(json.decode(response.body));
    // });
  }

  static showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String message) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(message ?? 'You are offline'),
    ));
  }
}
