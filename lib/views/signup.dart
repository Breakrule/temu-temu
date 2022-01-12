import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:temutemu/util/email_validator.dart';
import 'package:temutemu/view_models/RegisterSession.dart';
import 'package:temutemu/views/dashboard.dart';
import 'package:temutemu/views/login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var selectedType;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<String> _value=<String>[
    'Event Organizer',
    'Participant',
  ];

  SharedPreferences _sharedPreferences;
  bool _isError = false;
  bool _obscureText = true;
  bool _isLoading = false;
  bool _isHidden = true;
  TextEditingController _usernameController,
      _emailController,
      _passwordController;
  String _errorText, _usernameError, _emailError, _passwordError;
  int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    _usernameController = new TextEditingController();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
  }

  //SIGNUP STORE
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

  _signupStore() async {
    _showLoading();
    if (_valid()) {
      var responseJson = await RegisterSession.postUser(
          _usernameController.text,
          _emailController.text,
          _passwordController.text);
      debugPrint('asdasffffffggggggggggg');
      print('asdasd: $responseJson');

      if (responseJson == null) {
        RegisterSession.showSnackBar(_scaffoldKey, 'Something went wrong!');
      } else if (responseJson == 'NetworkError') {
        RegisterSession.showSnackBar(_scaffoldKey, null);
      } else {
        // AuthUtils.insertDetails(_sharedPreferences, responseJson);
        /**
         * Removes stack and start with the new page.
         * In this case on press back on HomePage app will exit.
         * **/
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new Dashboard()));
      }
      _hideLoading();
    } else {
      setState(() {
        _isLoading = false;
        _usernameError;
        _emailError;
        _passwordError;
      });
    }
  }



  _valid() {
    bool valid = true;
    if (_usernameController.text.isEmpty) {
      valid = false;
      _usernameError = "Username can't be blank!";
    }
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
          children: <Widget>[
            new CircularProgressIndicator(strokeWidth: 4.0),
            new Container(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                'Please Wait',
                style:
                    new TextStyle(color: Colors.grey.shade500, fontSize: 16.0),
              ),
            )
          ],
        )));
  }

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
      _isHidden = !_isHidden;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: new Text('SIGN UP',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xFF26C6DA),
                  fontFamily: 'Monserrat')),
          leading: new IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFF26C6DA)),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
          centerTitle: true,
        ),
        body: _isLoading
            ? _loadingScreen()
            : Stack(
                children: <Widget>[
                  _showBody(),
                ],
              ));
  }

  // Widget _profilePic(){
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(100.0, 0.0, 100.0, 0.0),
  //     child: new Container(
  //                 width: 125.0,
  //                 height: 125.0,
  //                   decoration: new BoxDecoration(
  //                       shape: BoxShape.circle,
  //                       image: new DecorationImage(
  //                       fit: BoxFit.fill,
  //                       image: new AssetImage(
  //                             "assets/images/default.png")
  //                             )
  //                   )
  //               ),
  //   );
  // }

  // Widget _showNameInput() {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
  //     child: new TextFormField(
  //       maxLines: 1,
  //       keyboardType: TextInputType.text,
  //       autofocus: false,
  //       decoration: new InputDecoration(
  //           hintText: 'Nama Lengkap',
  //           icon: new Icon(
  //             Icons.contacts,
  //             color: Colors.grey,
  //           )),
  //       validator: (value) => value.isEmpty ? 'This can\'t be empty' : null,
  //     ),
  //   );
  // }

  Widget _showUsername() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: _usernameController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          errorText: _usernameError,
            hintText: 'Username',
            icon: new Icon(
              Icons.person,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'This can\'t be empty' : null,
      ),
    );
  }

  Widget _showDropdown() {
    return Padding(
    padding: const EdgeInsets.fromLTRB(1.0, 10.0, 0.0, 0.0),
    child : new Row(
      children: <Widget>[
        Icon(Icons.offline_pin, color: Colors.grey),
        SizedBox(width: 13.0,),
          DropdownButton(
            items: _value.map((value)=>DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                value: value,
              )).toList(),
            elevation: 1,
            onChanged: (newValue){
              setState(() {
              selectedType = newValue; 
              });
            },
            value: selectedType,
            isExpanded: false,
            hint: Text('Choose Account Category                '),
          )
      ],
    ));
  }  

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  Widget _showGenderInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 10.0, 0.0, 0.0),
      child: new Row(
        children: <Widget>[
          new Radio(
            value: 1,
            groupValue: selectedRadio,
            onChanged: (val) {
              print("Radio $val");
              setSelectedRadio(val);
            },
          ),
          new Text('Pria',
              style: new TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                  fontFamily: 'Monserrat-Light')),
          new Radio(
            value: 2,
            groupValue: selectedRadio,
            onChanged: (val) {
              print("Radio $val");
              setSelectedRadio(val);
            },
          ),
          new Text('Wanita',
              style: new TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                  fontFamily: 'Monserrat-Light')),
        ],
      ),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: _emailController,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          errorText: _emailError,
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: _passwordController,
        maxLines: 1,
        obscureText: _obscureText,
        autofocus: false,
        decoration: new InputDecoration(
          errorText: _passwordError,
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            ),
            suffixIcon: IconButton(
              onPressed: _togglePassword,
              icon: _isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
            )
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
      ),
    );
  }

  // Widget _showNumberInput() {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
  //     child: new TextFormField(
  //       maxLines: 1,
  //       keyboardType: TextInputType.number,
  //       autofocus: false,
  //       decoration: new InputDecoration(
  //           hintText: 'Nomor Telepon',
  //           icon: new Icon(
  //             Icons.phone,
  //             color: Colors.grey,
  //           )),
  //       validator: (value) => value.isEmpty ? 'This can\'t be empty' : null,
  //     ),
  //   );
  // }

  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
        child: new MaterialButton(
          shape: RoundedRectangleBorder(
              //borderRadius: new BorderRadius.circular(25.0),
              ),
          elevation: 2.0,
          minWidth: 200.0,
          height: 42.0,
          color: Color(0xFF26C6DA),
          child: new Text('Create Account',
              style: new TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                  fontFamily: 'Monserrat')),
          onPressed: () {
            debugPrint("asdffdfdfdf");
            _signupStore();
          },
        ));
  }

  /*Widget _showSecondaryButton(){
    FacebookSignInButton(onPressed: (){

    });
  }*/
  /*Widget _showSecondaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
        child: new MaterialButton(
          shape: RoundedRectangleBorder(
            //borderRadius: new BorderRadius.circular(25.0),
          ),
          elevation: 5.0,
          minWidth: 200.0,
          height: 42.0,
          color: Colors.blue,
          child:
              new Text('Login',
                  style: new TextStyle(fontSize: 12.0, color: Colors.white, fontFamily: 'Monserrat')),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => LoginPage()));  
                      },
        ));
  }*/
  Widget _showBody() {
    return new Container(
        width: 1000,
        height: 1000,
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: new Form(
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              // _profilePic(),
              // _showNameInput(),
              _showUsername(),
              // _showGenderInput(),
              _showEmailInput(),
              _showPasswordInput(),
              // _showNumberInput(),
              _showDropdown(),
              _showPrimaryButton(),
              //_showSecondaryButton(),
            ],
          ),
        ));
  }
}

/*class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Signup',
                    style:
                        TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'PASSWORD ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    obscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'NICK NAME ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 50.0),
                  Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              'SIGNUP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1.0),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: 
                        
                            Center(
                              child: Text('Go Back',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),
                        ),
                    ),
                  ),
                ],
              )),
        ]));
  }
}*/
