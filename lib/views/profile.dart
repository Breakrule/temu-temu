import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dashboard.dart';

class Profile extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _Profile();

}

class _Profile extends State<Profile>{

  File _image;

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

  bool _obscureText = true;
  bool _isHidden = true;

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: new Text('PROFILE', textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, color: Color(0xFF26C6DA), fontFamily: 'Monserrat')),
        leading: new IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF26C6DA)),          
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()));  
            },
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          
          _showBody(),
        ],
      )
    );
  }

  Widget _profilePic(){
    return Padding(
      
      padding: const EdgeInsets.fromLTRB(100.0, 0.0, 100.0, 0.0),
      child: new GestureDetector(
        onTap: (){
          getImageFromGallery();
        },
      child: new Container(
                  width: 125.0,
                  height: 125.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage(
                              "assets/images/default.png")
                              )
                    )
                ),
      )
    );
  }

  Widget _showNameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        cursorColor: Color(0xFF26C6DA),
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Nama Lengkap',
            icon: new Icon(
              Icons.contacts,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'This can\'t be empty' : null,
      ),
    );
  }

  Widget _showUsername() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        cursorColor: Color(0xFF26C6DA),
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Username',
            icon: new Icon(
              Icons.person,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'This can\'t be empty' : null,
      ),
    );
  }

  int selectedRadio;
  @override
  void initState(){
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val){
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
            onChanged: (val){
              print("Radio $val");
              setSelectedRadio(val);
            },
          ),
            new Text(
              'Pria',
              style: new TextStyle(fontSize: 15.0, color: Colors.grey, fontFamily: 'Monserrat-Light')
            ),
          new Radio(
            value: 2,
            groupValue: selectedRadio,
            onChanged: (val){
              print("Radio $val");
              setSelectedRadio(val);
            },
          ),
            new Text(
              'Wanita',
              style: new TextStyle(fontSize: 15.0, color: Colors.grey, fontFamily: 'Monserrat-Light')
            ),
        ],
      ),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: new TextFormField(
        cursorColor: Color(0xFF26C6DA),
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
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
        maxLines: 1,
        obscureText: _obscureText,
        autofocus: false,
        decoration: new InputDecoration(
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

  Widget _showNumberInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        cursorColor: Color(0xFF26C6DA),
        maxLines: 1,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Nomor Telepon',
            icon: new Icon(
              Icons.phone,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'This can\'t be empty' : null,
      ),
    );
  }       

  Widget _showPrimaryButton() {
    return new Padding(

        padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
        child: new MaterialButton(

          elevation: 2.0,
          minWidth: 200.0,
          height: 42.0,
          color: Color(0xFF26C6DA),
          child:
              new Text('Simpan',
                  style: new TextStyle(fontSize: 13.0, color: Colors.white, fontFamily: 'Monserrat')),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => Dashboard()));  
                      },
        ),
        );
  }

  Widget _showBody(){
    return new Container(
        width: 1000,
        height: 1000,
        padding: EdgeInsets.all(16.0),
        color: Colors.white,
        child: new Form(
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _profilePic(),
              _showNameInput(),
              _showUsername(),
              _showGenderInput(),
              _showEmailInput(),
              _showPasswordInput(),
              _showNumberInput(),
              _showPrimaryButton(),
            ],
          ),
        ),
    );
  }

}