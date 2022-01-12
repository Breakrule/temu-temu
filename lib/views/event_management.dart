import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temutemu/models/Events.dart';

import 'package:temutemu/models/User.dart';
import 'package:temutemu/util/authutils.dart';
import 'package:temutemu/util/color.dart';
import 'package:temutemu/view_models/EventSession.dart';
import 'package:temutemu/views/dashboard.dart';
import 'package:intl/intl.dart';
import 'package:temutemu/util/color.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:path/path.dart';

var globalContext;

class EventManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    globalContext = context;
    // TODO: implement build
    return new MaterialApp(
      theme: ThemeData(
        primarySwatch: ColorStandard.color,
      ),
      home: EventManagementHome(),
    );
  }
}

class EventManagementHome extends StatefulWidget {
  EventManagementHome({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _EventManagementWidget();
}

class _EventManagementWidget extends State<EventManagementHome> {
  //final _formKey = GlobalKey<FormState>();
  bool _isError = false;
  bool _obscureText = true;
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _dariTanggal, _hinggaTanggal, _dariJam, _hinggaJam;
  DateTime _heldOn, _finished;
  TextEditingController titleController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController descriptionContoller = new TextEditingController();
  TextEditingController rundownController = new TextEditingController();
  TextEditingController flyerController = new TextEditingController();
  TextEditingController notelpController = new TextEditingController();
  String _titleError,
      _descriptionError,
      _rundownError,
      _heldOnError,
      _finishedError,
      _flyerError,
      _notelpError;
  File _image;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;
  var _authToken, _id, _name, _homeResponse;
  String authToken;

  @override
  void initState() {
    super.initState();
    _fetchSessionAndNavigate();
  }

  Future getImageFromCam() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('events/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      print("profile picture uploaded");
      // Scaffold.of(context).showSnackBar(SnackBar(
      //   content: Text('Profile picture uploaded'),
      // ));
    });
  }

  _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    authToken = AuthUtils.getToken(_sharedPreferences);
    debugPrint('fffffasdasdasdfffffffff: $authToken');
    // var id = _sharedPreferences.getInt(AuthUtils.userIdKey);
    // var name = _sharedPreferences.getString(AuthUtils.nameKey);

    print(authToken);

    // _fetchHome(authToken);

    setState(() {
      // _authToken = authToken;
      // _id = id;
      // _name = name;
    });
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

  _postEvents() async {
    _showLoading();
    if (_valid()) {
      Events events = new Events(
          user_id: 123,
          title: titleController.text,
          description: descriptionContoller.text,
          rundown: locationController.text,
          heldOn: _heldOn,
          finished: _finished,
          kode_event: 33333,
          no_telph: int.parse(notelpController.text));
      var responseJson =
          await EventSession().eventPost(AuthUtils.getToken(_sharedPreferences),  events.toJson());
      debugPrint('APAKAH BISA ? $authToken');
      print('APAKAH MERESPONSE ?: $responseJson');

      if (responseJson == null) {
        EventSession.showSnackBar(_scaffoldKey, 'Something went wrong!');
      } else if (responseJson == 'NetworkError') {
        EventSession.showSnackBar(_scaffoldKey, null);
      } else {
        //EventSession.insertDetails(_sharedPreferences, responseJson);
        /**
         * Removes stack and start with the new page.
         * In this case on press back on HomePage app will exit.
         * **/
        Navigator.pushReplacement(globalContext,
        new MaterialPageRoute(builder: (context) => new Dashboard()));
      }
      _hideLoading();
    } else {
      setState(() {
        _isLoading = false;
        _titleError;
        _descriptionError;
        _rundownError;
        _heldOnError;
        _finishedError;
        _flyerError;
        _notelpError;
      });
    }
  }

  _valid() {
    bool valid = true;
    if (titleController.text.isEmpty) {
      debugPrint('emaillll');
      valid = false;
      _titleError = "Name can't be blank!";
    }
    if (descriptionContoller.text.isEmpty) {
      valid = false;
      _descriptionError = "description can't be blank!";
    }
    return valid;
  }

  //LOADING WIDGET
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
    // TODO: implement build
    Size size = MediaQuery.of(context).size;

    return new Scaffold(
       key: _scaffoldKey,
        appBar: new AppBar(
          centerTitle: true,
          iconTheme: new IconThemeData(color: Color(0xFF26C6DA)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: new Text('EVENT MANAGEMENT',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xFF26C6DA),
                  fontFamily: 'Monserrat')),
          leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(globalContext);
            },
          ),
        ),
        body:_isLoading
            ? _loadingScreen()
            : SingleChildScrollView(
            child: new Stack(
          children: <Widget>[
            new GestureDetector(
              onTap: () {
                getImageFromGallery();
              },
              child: new Container(
                margin: const EdgeInsets.only(top: 10.0),
                padding: EdgeInsets.only(top: 20.0, left: 20.0),
                width: 500.0,
                height: 200.0,
                color: Colors.blueGrey,
                child: (_image != null)
                    ? Image.file(_image, fit: BoxFit.fill)
                    : new Icon(
                        Icons.photo_camera,
                        color: Colors.white,
                        size: 50,
                      ),
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(top: 175.0),
              padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                    child: new TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Mohon masukan nama event anda';
                        }
                        return null;
                      },
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 15),
                        hintText: 'Nama event',
                        labelText: 'Berikan nama event anda',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                    child: new DateTimeField(
                      format: DateFormat.yMMMMEEEEd("en_US").add_jm(),
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );
                          _heldOn = DateTimeField.combine(date, time);
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 15),
                        labelText: 'Tanggal & waktu diselenggarakan',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                    child: new DateTimeField(
                      format: DateFormat.yMMMMEEEEd("en_US").add_jm(),
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );
                          _finished = DateTimeField.combine(date, time);
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 15),
                        labelText: 'Tanggal & waktu berakhir',
                      ),
                    ),
                  ),
                  /*new Row(
                    children: <Widget>[                    
                    new Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: DateTimeField(
                            format: DateFormat("dd-MM-yyyy"),
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                                  
                            },
                              decoration: const InputDecoration(          
                              labelStyle: TextStyle(fontSize: 15),
                              labelText: 'Tanggal',
                            ),
                          ),
                        ),
                      ),
                    ),
                    new Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: new DateTimeField(
                          format: DateFormat("HH:mm"),
                          onShowPicker: (context, currentValue) async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now()),
                            );
                            
                            return DateTimeField.convert(time);
                          },
                          onSaved: (_valueJam) {
                            _hinggaJam = _valueJam.toString();
                            debugPrint(_hinggaJam);
                          },
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(fontSize: 15),
                            labelText: 'Hingga jam',
                          ),
                        ),
                      ),
                    ),
                    ]
                  ),*/
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                    child: new TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Mohon masukan lokasi event';
                        }
                        return null;
                      },
                      controller: locationController,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 15),
                        hintText: 'Cari lokasi',
                        labelText: 'Tentukan lokasi',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                    child: new TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Mohon masukan nomor telepon';
                        }
                        return null;
                      },
                      controller: notelpController,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 15),
                        hintText: 'Masukan nomor yang dapat dihubungi',
                        labelText: 'Nomor Telepon',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                    child: new TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Mohon masukan email';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 15),
                        hintText: 'Masukan email yang dapat dihubungi',
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                    child: new TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Mohon masukan deskripsi event';
                        }
                        return null;
                      },
                      controller: descriptionContoller,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 15),
                        hintText: 'Deskripsi event',
                        labelText: 'Deskripsikan event anda',
                      ),
                    ),
                  ),
                  // ListView(
                  //   children: <Widget>[
                  //      Container(
                  //       width: size.width,
                  //       height: 100.0,
                  //       child: Center(
                  //         child: _image == null
                  //         ? Text('No Image Selected')
                  //         : Image.file(_image)
                  //       ),
                  //     ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: <Widget>[
                  //         FloatingActionButton(
                  //           onPressed: getImageFromCam,
                  //           tooltip: 'Pick Image',
                  //           child: Icon(Icons.add_a_photo),
                  //         ),
                  //          FloatingActionButton(
                  //           onPressed: getImageFromGallery,
                  //           tooltip: 'Pick Image',
                  //           child: Icon(Icons.add_a_photo),
                  //         )
                  //       ],
                  //     )
                  //   ],
                  // ),

                  SizedBox(height: 5.0),
                  Container(
                    padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                    width: size.width,
                    child: RaisedButton(
                      color: new Color(0xff3aaab7),
                      onPressed: () {
                        _postEvents();
                        uploadPic(context);
                        // if (_formKey.currentState.validate()) {
                        //   Scaffold.of(context).showSnackBar(
                        //       SnackBar(content: Text('Processing Data')));
                        // }
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => EventManagement()));
                      },
                      child: Text(
                        'Create Event',
                        style: new TextStyle(
                            color: Colors.white,
                            fontFamily: 'Monserrat',
                            fontSize: 13.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}
