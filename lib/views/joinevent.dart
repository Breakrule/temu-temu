import 'package:flutter/material.dart';
import 'package:temutemu/views/event_detail.dart';
import 'package:temutemu/views/profile.dart';

var globalContext;

class JoinEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    globalContext = context;
    // TODO: implement build
    return MaterialApp(
      home: JoinEventWidget(),
    );
  }
}

class JoinEventWidget extends StatefulWidget {
  JoinEventWidget({Key key}) : super(key: key);
  @override
  JoinEventWidgetState createState() => JoinEventWidgetState();
}

class JoinEventWidgetState extends State<JoinEventWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: ()async {
      Navigator.pop(context,true);
      return false;
      },
    child: Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.lightBlue),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: new Text('TEMU TEMU', textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, color: Color(0xFF26C6DA), fontFamily: 'Monserrat')),
        leading: new IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF26C6DA),
          onPressed: () {
            Navigator.pop(globalContext,true);
          },
        ),
      ),
      body: new Stack(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('JOIN EVENT'),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Enter a conference code, then enter it here'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: new TextFormField(
                    textAlign: TextAlign.left,
                    decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.all(20.0),
                      labelText: 'Invitation Code',
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    validator: (val) {
                      if (val.length == 0) {
                        return "Code cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: new RaisedButton(
                    color: Color(0xFF26C6DA),
                    textColor: Colors.white,
                    onPressed: () {
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) => EventDetail()));
                          },
                    child:
                        Text('Join Event', style: new TextStyle(fontSize: 13.0, color: Colors.white, fontFamily: 'Monserrat')),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
