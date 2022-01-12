import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temutemu/views/profile.dart';

class AppBarStandard  {
  void navigationdrawer(BuildContext context) {
    Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Erlangga Pratama Putra'),
              accountEmail: Text('erlanggapratamaputra6@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text("Edit Profile"),
              trailing: Icon(Icons.arrow_drop_down),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            ListTile(
              title: Text("Setting"),
              trailing: Icon(Icons.arrow_drop_down),
            ),
            ListTile(
              title: Text("Terms of Service"),
              trailing: Icon(Icons.arrow_drop_down),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return Scaffold();
  // }
}


