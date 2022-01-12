import 'dart:core' as prefix0;
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'event_detail.dart';

class Comment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _Comment();
}

class _Comment extends State<Comment> {
  prefix0.List<prefix0.String> _comment = [];

  void _addComment(prefix0.String val){
    setState(() {
     _comment.add(val); 
    });
  }

  Widget _buildCommentList() {
    return ListView.builder(
      itemBuilder: (context, index){
        if (index < _comment.length){
          return _buildCommentItem(_comment[index]);
        }
      }
    );
  }

  Widget _buildCommentItem(prefix0.String comment){
    return ListTile(title: Text(comment));
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: new Text('COMMENT',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15.0,
                color: Color(0xFF26C6DA),
                fontFamily: 'Monserrat')),
        leading: new IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF26C6DA)),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EventDetail()));
          },
        ),
        centerTitle: true,
      ),

      body: Stack(
      children: <Widget>[
        
      _showBody(),
      Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[500],
                      offset: Offset(0.0, 1.5),
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                constraints: BoxConstraints(
                  maxHeight: 190,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: ListTile(

                        contentPadding: EdgeInsets.all(0),
                        title: TextField(
                          showCursor: true,
                          cursorColor: Color(0xFF26C6DA),
                          onSubmitted: (prefix0.String submittedStr){
                            _addComment(submittedStr);
                          },
                          decoration: InputDecoration(            
                            contentPadding: const EdgeInsets.all(10.0),
                            hintText: "Enter a comment...",
                            hintStyle: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.grey,
                                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ],

      /*body: new Container(
      color: Colors.white,
      child :Column(children: <Widget>[Expanded(child: _buildCommentList()),
      ListTile(
        title: TextField(
          showCursor: true,
          cursorColor: Color(0xFF26C6DA),
          onSubmitted: (prefix0.String submittedStr){
            _addComment(submittedStr);
          },
          decoration: InputDecoration(            
            contentPadding: const EdgeInsets.all(10.0),
            hintText: "Enter a comment...",
            hintStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
          ),
        ),
      )
      ],
      ), */
      ),
    );
  }

  Widget _showComment() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new AssetImage(
                              "assets/images/default.png")))),
              title: Text(
                'Username :',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    fontFamily: 'Montserrat'),
              ),
              subtitle: Text(
                'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
                style: TextStyle(
                    color: Colors.grey, fontSize: 11, fontFamily: 'Montserrat'),
              ),
            ),
          ),
        ],
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
            _showComment(),
            _showComment(),
            _showComment(),
            _showComment(),
            _showComment(),
            _showComment(),
            _showComment(),
            _showComment(),
            _showComment(),
            _showComment()
            ],
          ),
        ),
    );
  }

}
