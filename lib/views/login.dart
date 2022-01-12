import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:temutemu/util/authutils.dart';
import 'package:temutemu/util/color.dart';
import 'package:temutemu/util/email_validator.dart';
import 'package:temutemu/util/networkutils.dart';
import 'package:temutemu/views/dashboard.dart';
import 'package:temutemu/views/signup.dart';
import 'package:temutemu/views/forpswd.dart';

var globalContext;
//ProgressDialog pr;

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    globalContext = context;
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: ColorStandard.color[55],
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  SharedPreferences _sharedPreferences;
  bool _isError = false;
  bool _obscureText = true;
  bool _isLoading = false;
  TextEditingController _emailController, _passwordController;
  String _errorText, _emailError, _passwordError;

  @override
  void initState() {
    super.initState();
    _fetchSessionAndNavigate();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
  }

  bool _isHidden = true;

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
      _isHidden = !_isHidden;
    });
  }

  _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);
    debugPrint('INIIIII TOKEN : $authToken');
    if (authToken != null) {
      /*Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new Dashboard()));
    */
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context)=> Dashboard()),
        );
      //Navigator.push(context, new MaterialPageRoute(builder: (context) => new Dashboard()));
    }
  }

  _showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  _hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  _authenticateUser() async {
    _showLoading();
    if (_valid()) {
      var responseJson = await NetworkUtils.authenticateUser(
          _emailController.text, _passwordController.text);

      print('asdasd: $responseJson');

      if (responseJson == null) {
        NetworkUtils.showSnackBar(_scaffoldKey, 'Something went wrong!');
      } else if (responseJson == 'NetworkError') {
        NetworkUtils.showSnackBar(_scaffoldKey, null);
      } else if (responseJson['errors'] != null) {
        NetworkUtils.showSnackBar(_scaffoldKey, 'Invalid Email/Password');
      } else {
        AuthUtils.insertDetails(_sharedPreferences, responseJson);
        /**
         * Removes stack and start with the new page.
         * In this case on press back on HomePage app will exit.
         * **/
        /*Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new Dashboard()));
      */
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => new Dashboard()));
      }
      _hideLoading();
    } else {
      setState(() {
        _isLoading = false;
        _emailError;
        _passwordError;
      });
    }
  }

  _valid() {
    bool valid = true;
    if (_emailController.text.isEmpty) {
      debugPrint('emaillll');
      valid = false;
      _emailError = "Email can't be blank!";
    } else if (!_emailController.text.contains(EmailValidator.regex)) {
      valid = false;
      _emailError = "Enter valid email!";
    }
    if (_passwordController.text.isEmpty) {
      valid = false;
      _passwordError = "Password can't be blank!";
    } else if (_passwordController.text.length < 6) {
      valid = false;
      _passwordError = "Password is invalid!";
    }
    return valid;
  }

  Widget _loadingScreen() {
    return new Container(
        margin: const EdgeInsets.only(top: 100.0),
        child: new Center(
          child: new Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: <Widget>[
          new CircularProgressIndicator(strokeWidth: 4.0),
            new Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.center,
              child: new Text(
                'Please Wait...',
                style:
                    new TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            )
          ],
        )));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
        key: _scaffoldKey,
        body: _isLoading
            ? _loadingScreen()
            : SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(10.0, 55.0, 0.0, 0.0),
                          child: Text('T',
                              style: TextStyle(
                                  fontSize: 190.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(100.0, 100.0, 0.0, 0.0),
                          child: Text('emu',
                              style: TextStyle(
                                  fontSize: 80.0, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(100.0, 155.0, 0.0, 0.0),
                          child: Text('emu.',
                              style: TextStyle(
                                  fontSize: 80.0, fontWeight: FontWeight.bold)),
                        ),
                        /*Container(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          width: 250,
                          height: 250,
                          decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              'assets/images/logo_transparent' ),
                        ),
                    ),
                ),*/
                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 250.0, 0.0, 0.0),
                          child: Text('Hello',
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 270.0, 0.0, 0.0),
                          child: Text('Indonesia, Jakarta 14710',
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding:
                          EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: InputDecoration(
                              errorText: _emailError,
                              labelText: 'Email address',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF26C6DA))),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(                              
                                errorText: _passwordError,
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xFF26C6DA))),
                                suffixIcon: IconButton(
                                  onPressed: _togglePassword,
                                  icon: _isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                                )
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            alignment: Alignment(1.0, 0.0),
                            padding: EdgeInsets.only(top: 15.0, right: 192.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ForgotPage()));
                              },    
                              child: InkWell(
                                child: Text(
                                  'Forgot your password ?',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      fontSize: 12.0,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                          ),
                          
                          SizedBox(height: 25.0),
                          Container(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            width: size.width,
                            //height: 40.0,
                            child: RaisedButton(
                              child: Text("Login",style: new TextStyle(fontSize: 13.0, color: Colors.white, fontFamily: 'Monserrat')),
                              color: new Color(0xFF26C6DA),
                              onPressed: () {
                                debugPrint('tes');
                                _authenticateUser();
                              },
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top: 10.0, right: 215.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupPage()));
                      },
                      child: InkWell(
                        child: Text(
                          'Dont have an account ?',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              fontSize: 12.0,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  )
                ],
              )
            )
          );
  }
}
