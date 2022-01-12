import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:temutemu/views/comment.dart';
import 'package:temutemu/views/dashboard.dart';
import 'package:temutemu/views/joinevent.dart';
class EventDetail extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _EventDetail();
  
}

class _EventDetail extends State<EventDetail>{

  @override
  Widget build(BuildContext context) {
    
    return new WillPopScope(
    onWillPop: ()async {
      Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => JoinEvent()));
            return false;
    },
    child: Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: new Text('A1D3DFX', textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, color: Color(0xFF26C6DA), fontFamily: 'Monserrat')),
        leading: new IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF26C6DA)),          
            onPressed: () {
              Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => JoinEvent()));  
            },
        ),
        centerTitle: true,
    ),
      
      body: Stack(
        children: <Widget>[          
          
          _showBody(),
        ],
      ),
    ));
  }

  Widget _eventPic(){
    return Padding(
      
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: new Container(
                  width: 250,
                  height: 250,
                    decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage(
                              "assets/images/1.jpg" ),
                        ),
                    ),
                ),
    );
  }

  Widget _eventTitle() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: ListTile(

                  contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),                  

                  leading: Text('Bukber Kelas 3A IT Telkom Purwokerto',
                              style: TextStyle(
                                  color: Color(0xFF26C6DA),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  fontFamily: 'Montserrat'
                                  ),
                            ),

                ),
              ),
            ],
          ),
  );
  }

  Widget _pelaksanaan(){
    return Padding(
      
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: new Container(
        width: 200.0,
        height: 125.0,
        decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      offset: Offset(0.0, 0.5),
                      blurRadius: 2.0,
                    ),
                  ],
        ),
        padding: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
        child: GridTile(           
          child: Text('',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 13,
                fontFamily: 'Montserrat'),
          ),

          header: ListTile(
            contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
            leading: Icon(
                          Icons.calendar_today,
                          color: Color(0xFF26C6DA),
                        ),

            title: Text('Minggu, 13 Oktober 2019',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: 'Montserrat'),
                      ),

            subtitle: Text('10.00 am - 12.00 pm',
                            style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontFamily: 'Montserrat'),   
            ),
          ),
          footer: ListTile(
            contentPadding: EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 0.0),
            leading:  Icon(
                          Icons.location_on,
                          color: Color(0xFF26C6DA),                        
                        ),

            title: Text('Bundaran HI',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: 'Montserrat'),
                      ),

            subtitle: Text('Jalan Kebon Melati 1, No.5, Menteng, Jakarta Pusat',
                            style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontFamily: 'Montserrat'),   
            ),
          ),
      ),
                    
      ),
    );
  }

  Widget _infoDetail(){
    return Padding(
      
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      child: new Container(
        width: 200.0,
        height: 125.0,
        decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      offset: Offset(0.0, 0.5),
                      blurRadius: 2.0,
                    ),
                  ],
        ),
        child: GridTile(

          child: Text('',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: 'Montserrat'),
                      ),
                    
          header: ListTile(
            contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
            leading: Icon(
                          Icons.phone,
                          color: Color(0xFF26C6DA),
                        ),

            title: Text('+7 333 782-42-32',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: 'Montserrat'),
                      ),

            subtitle: Text('mobile',
                            style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: 'Montserrat'),   
            ),
          ),
          footer: ListTile(
            contentPadding: EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 0.0),
            leading:  Icon(
                          Icons.email,
                          color: Color(0xFF26C6DA),                        
                        ),

            title: Text('osc.amer@mabok.com',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: 'Montserrat'),
                      ),

            subtitle: Text('Home',
                            style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: 'Montserrat'),   
            ),
          ),
          
      ),
                    
      ),
    );
  }

  Widget _infoEvent(){
    return Padding(
      
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      child: new Container(
        width: 200.0,
        height: 125.0,
        decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      offset: Offset(0.0, 0.5),
                      blurRadius: 2.0,
                    ),
                  ],
        ),
        child: GridTile(

          child: Text('',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: 'Montserrat'),
                      ),
                    
          header: ListTile(
            contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
            title: Text('Detail Event',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: 'Montserrat'),
                      ),
            subtitle: Text('Indonesia Color Run adalah wujud kecintaan masyarakat Indonesia Pada Pancasila. Motto IDCR adalah Menyatukan Warna Indonesia. Motto ini sangat memiliki arti melihat indonesia sebagai negara yang beranekaragam suku,bahasa dan agama...',
                            style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontFamily: 'Montserrat'),   
            ),
          ),
          
      ),
                    
      ),
    );
  }

  Widget _showComment() {
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
      child: new MaterialButton(
          elevation: 1.5,
          minWidth: 75.0,
          height: 15.0,
          color: Color(0xFF26C6DA),
          child : ListTile(
            contentPadding: EdgeInsets.fromLTRB(60.0, 0.0, 0.0, 0.0),
            leading: Icon(
                          Icons.comment,
                          color: Colors.white,
                        ),

            title: Text('Lihat Komentar...',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                            fontFamily: 'Montserrat'),
                      ),
          ),
          onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => Comment()));  
                      },
      ),
    );
  }

  Widget _showBody(){
    return new Container(
        height: 1000,
        width: 1000,

        padding: EdgeInsets.all(16.0),
        color: Colors.white,
        child: new Form(
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _eventPic(),
              _eventTitle(),
              _pelaksanaan(),              
              _infoDetail(),
              _infoEvent(),
              _showComment(),
            ],
          ),
        ),
    );
  }}