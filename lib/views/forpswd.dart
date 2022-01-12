import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//import 'package:temutemu/views/dashboard.dart';
import 'package:temutemu/views/login.dart';

class ForgotPage extends StatefulWidget {
  @override
  _ForgotPageState createState() => _ForgotPageState();

}
class _ForgotPageState extends State<ForgotPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      /*appBar: new AppBar(
        title: new Text('Forgot Password'),
        centerTitle: true,
      ),*/
      body: Stack(
        children: <Widget>[
          
          _showBody(),
        ],
      )
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 200.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Color(0xFF26C6DA),
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
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
              new Text('Reset Password',
                  style: new TextStyle(fontSize: 13.0, color: Colors.white, fontFamily: 'Monserrat')),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => LoginPage()));  
                      },
        ),
        );
  }

  Widget _showBody(){
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showEmailInput(),
              _showPrimaryButton(),
            ],
          ),
        ));
  }

}