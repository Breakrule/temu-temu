import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:temutemu/util/Constanst.dart';
import 'package:temutemu/util/authutils.dart';
import 'package:temutemu/util/color.dart';
import 'package:temutemu/util/networkutils.dart';
import 'package:temutemu/views/event_management.dart';
import 'package:temutemu/views/joinevent.dart';
import 'package:temutemu/views/profile.dart';
import 'login.dart';
var globalContext;

class Dashboard extends StatelessWidget {
  static final String routeName = 'home';
  @override
  Widget build(BuildContext context) {
    // final AuthenticationBloc authenticationBloc =
    //     BlocProvider.of<AuthenticationBloc>(context);
  
    return new MaterialApp(
      theme: ThemeData(
        primarySwatch: ColorStandard.color,
        //primarySwatch: ColorStandard.color,
      ),
      title: 'Welcome to temutemu',
      home: DashboardHome(),
    );
  }
}

class DashboardHome extends StatefulWidget {
  DashboardHome({Key key}) : super(key: key);

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardHome> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
	Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  
  int _angle = 90;
  bool _isRotated = true;

  AnimationController _controller;
  Animation<double> _animation;
  Animation<double> _animation2;
  Animation<double> _animation3;

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );

    _animation = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.0, 1.0, curve: Curves.linear),
    );

    _animation2 = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.5, 1.0, curve: Curves.linear),
    );

    _animation3 = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.8, 1.0, curve: Curves.linear),
    );
    _controller.reverse();
    super.initState();
  }

  void _rotate(){
    setState((){
      if(_isRotated) {
        _angle = 45;
        _isRotated = false;
        _controller.forward();
      } else {
        _angle = 90;
        _isRotated = true;
        _controller.reverse();
      }
    });
  }

	SharedPreferences _sharedPreferences;
	var _authToken, _id, _name, _homeResponse;

  _fetchSessionAndNavigate() async {
		_sharedPreferences = await _prefs;
		String authToken = AuthUtils.getToken(_sharedPreferences);
    debugPrint('ffffffffffffffffff: $authToken');
		// var id = _sharedPreferences.getInt(AuthUtils.userIdKey);
		// var name = _sharedPreferences.getString(AuthUtils.nameKey);

		print(authToken);

		// _fetchHome(authToken);

		setState(() {
			_authToken = authToken;
			// _id = id;
			// _name = name;
		});

		if(_authToken == null) {
			_logout();
		}
	}

  // _fetchHome(String authToken) async {
	// 	var responseJson = await NetworkUtils.fetch(authToken, '/api/v1/home');

	// 	if(responseJson == null) {

	// 		NetworkUtils.showSnackBar(_scaffoldKey, 'Something went wrong!');

	// 	} else if(responseJson == 'NetworkError') {

	// 		NetworkUtils.showSnackBar(_scaffoldKey, null);

	// 	} else if(responseJson['errors'] != null) {

	// 		_logout();

	// 	}

	// 	setState(() {
	// 	  _homeResponse = responseJson.toString();
	// 	});
	// }
  /*void choiceAction(String choice) {
    if (choice == Constants.join) {
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => JoinEvent()));
    } else if (choice == Constants.create) {
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => EventManagement()));
    }
  }*/ 

  _logout() {
		NetworkUtils.logoutUser(_scaffoldKey.currentContext, _sharedPreferences);
	}
  //  @override
  // void initState() {
  //   super.initState();
    
  // }
  createAlertDialog(BuildContext context){
    return showDialog(context: context, builder: (context){
      return SimpleDialog(        
        children: <Widget>[
          SimpleDialogOption(
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => JoinEvent()));
              },
              child: const Text('Join Event', textAlign : TextAlign. center, style: TextStyle(fontSize: 15.0,)),
            ),
          SimpleDialogOption(
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => EventManagement()));
              },
              child: const Text('Create Event', textAlign : TextAlign. center, style: TextStyle(fontSize: 15.0,)),
            ),
        ]
      );
    });
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    
    // final AuthenticationBloc authenticationBloc =
    //     BlocProvider.of<AuthenticationBloc>(globalContext);
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        centerTitle: true,
        iconTheme: new IconThemeData(color: Color(0xFF26C6DA)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: new Text('TEMU TEMU', textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, color: Color(0xFF26C6DA), fontFamily: 'Monserrat')),
        actions: <Widget>[
         /* PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },child: Icon(Icons.add, size:30, color: Color(0xFF26C6DA)),
          )*/
        ],
      ),
      drawer: Drawer(
      
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Erurangga Pratama Putra'),
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
              trailing: Icon(Icons.supervised_user_circle),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            ListTile(
              title: Text("Setting"),
              trailing: Icon(Icons.settings),
              /*onTap: (){
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => AppSettings.openLocationSettings()));
              },*/
            ),
            ListTile(
              title: Text("Terms of Service"),
              trailing: Icon(Icons.vpn_key),
            ),
            ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.add_to_home_screen),
              onTap: () {
                //Navigator.push(context, new MaterialPageRoute(builder: (context) => new LoginPage()));
                _logout();
               },
            ),
          ],
        ),
      
      ),
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage("assets/images/bg_dashboard.png"))),
          ),
          new Container(
              alignment: Alignment.topCenter,
              padding: new EdgeInsets.only(top: 120.0),
              child: new Text(
                'Lets Meet Again',
                textAlign: TextAlign.right,
                style: new TextStyle(
                  fontSize: 34.0,
                  fontFamily: 'Monserrat-Bold',
                  fontWeight: FontWeight.w800,
                  color: new Color(0xFF26C6DA),
                ),
              )
            ),
          new Positioned(
            bottom: 155.0,
            right: 16.0,
            child: new Container(
              child: new Row(
                children: <Widget>[
                  new ScaleTransition(
                    scale: _animation2,
                    alignment: FractionalOffset.center,
                    child: new Container(
                      margin: new EdgeInsets.only(right: 16.0),
                      child: new Text(
                        'Join Event',
                        style: new TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Roboto',
                          color: new Color(0xFF26C6DA),
                          fontWeight: FontWeight.bold,
                        ),
                      ), 
                    ),
                  ),

                  new ScaleTransition(
                    scale: _animation2,
                    alignment: FractionalOffset.center,
                    child: new Material(
                      color: new Color(0xFFFFFFFF),
                      type: MaterialType.circle,
                      elevation: 2.0,
                      child: new GestureDetector(
                        child: new Container(
                          width: 56.0,
                          height: 56.0,
                          child: new InkWell(
                            onTap: (){
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context) => JoinEvent()));
                              if(_angle == 45.0){
                                print("Join Event");
                              }
                            },
                            child: new Center(
                              child: new Icon(
                                Icons.people,
                                color: new Color(0xFF26C6DA),
                              ),                      
                            ),
                          )
                        ),
                      )
                    ),
                  ), 
                ],
              ),
            )
          ),
          new Positioned(
            bottom: 86.0,
            right: 16.0,
            child: new Container(
              child: new Row(
                children: <Widget>[
                  new ScaleTransition(
                    scale: _animation,
                    alignment: FractionalOffset.center,
                    child: new Container(
                      margin: new EdgeInsets.only(right: 16.0),
                      child: new Text(
                        'Create Event',
                        style: new TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Roboto',
                          color: new Color(0xFF26C6DA),
                          fontWeight: FontWeight.bold,
                        ),
                      ), 
                    ),
                  ),

                  new ScaleTransition(
                    scale: _animation,
                    alignment: FractionalOffset.center,
                    child: new Material(
                      color: new Color(0xFFFFFFFF),
                      type: MaterialType.circle,
                      elevation: 2.0,
                      child: new GestureDetector(
                        child: new Container(
                          width: 56.0,
                          height: 56.0,
                          child: new InkWell(
                            onTap: (){
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context) => EventManagement()));                              
                              if(_angle == 45.0){
                                print("Create Event");
                              }
                            },
                            child: new Center(
                              child: new Icon(
                                Icons.event_available,
                                color: new Color(0xFF26C6DA),
                              ),                      
                            ),
                          )
                      ),
                    )
                    ),
                  ), 
                ],
              ),
            )
          ),
          new Positioned(
            bottom: 16.0,
            right: 16.0,
            child: new Material(
              color: new Color(0xFF26C6DA),
              type: MaterialType.circle,
              elevation: 2.0,
              child: new GestureDetector(
                child: new Container(
                  width: 56.0,
                  height: 56.0,
                  child: new InkWell(
                    onTap: _rotate,
                    child: new Center(
                      child: new RotationTransition(
                        turns: new AlwaysStoppedAnimation(_angle / 360),
                        child: new Icon(
                          Icons.add,
                          color: new Color(0xFFFFFFFF),
                        ),
                      )
                    ),
                  )
                ),
              )
            ),
          ),
        ],
      ),
        /*floatingActionButton : FloatingActionButton(
          backgroundColor: Color(0xFF26C6DA),
          onPressed: () {
            createAlertDialog(context);
          },
          child: Icon(Icons.add),          
          elevation: 2.0,  
        ),*/
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     return Constants.choices.map((String choice) {u
      //       return PopupMenuItem<String>(
      //         value: choice,
      //         child: Text(choice),
      //       );
      //     }).toList();
      //     //   actions: <Widget>[
      //     //   PopupMenuButton<String>(
      //     //     onSelected: choiceAction,
      //     //     itemBuilder: (BuildContext context){
      //     //       return Constants.choices.map((String choice){
      //     //         return PopupMenuItem<String>(
      //     //           value: choice,
      //     //           child: Text(choice),
      //     //         );
      //     //       }).toList();
      //     //     },
      //     //   )
      //     // ];
      //     // Navigator.push(context,
      //     //     MaterialPageRoute(builder: (context) => EventManagement()));
      //   },

      //   child: Icon(
      //     Icons.add,
      //   ),

      //   // shape: RoundedRectangleBorder(borderRadius:
      //   // BorderRadius.all(Radius.circular(16.0)),
      // ),
      
    );
  }
}
