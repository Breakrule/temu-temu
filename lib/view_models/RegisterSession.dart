import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temutemu/models/Events.dart';
import 'package:temutemu/models/User.dart';

class RegisterSession {
  static final String host = productionHost;
  static final String productionHost = 'http://temutemu.herokuapp.com';
  static String getToken(SharedPreferences prefs) {
    var authTokenKey;
    return prefs.getString(authTokenKey);
  }

   static dynamic postUser(
     String username,
     String email,
     String password) async {
    return await http.post('http://temutemu.herokuapp.com/users', headers: {
    }, body: {
      'username': username,
      'email' : email,
      'password' : password
    }).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return User.fromJson(json.decode(response.body));
    });
  }

  static showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String message) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(message ?? 'You are offline'),
    ));
  }
}
