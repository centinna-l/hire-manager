import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hire_manager/values/global_variable.dart';

import 'demologin.dart';

class QuestionSendPage extends StatefulWidget {
  @override
  _QuestionSendPageState createState() => _QuestionSendPageState();
}

class _QuestionSendPageState extends State<QuestionSendPage> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String _question, op1, op2, op3, op4, answer;
  GloabalVariable email = new GloabalVariable();
  var _questionController = TextEditingController();
  var _op1Controller = TextEditingController();
  var _op2Controller = TextEditingController();
  var _op3Controller = TextEditingController();
  var _op4Controller = TextEditingController();
  var _answerController = TextEditingController();
   @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser();
      if (user != null) {
        loggedInUser = user as FirebaseUser;
        debugPrint(loggedInUser.email);
      } else {
        Navigator.of(this.context).pushReplacement(
            MaterialPageRoute(builder: (context) => DemoLogin()));
      }
    } catch (e) {
      debugPrint(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _modifiedBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          debugPrint("Clicked");
            _firestore.collection("questions").add({
              'question': _question,
              'op1': op1,
              'op2': op2,
              'op3': op3,
              'op4': op4,
              'answer': answer,
              'email': email.email
            });
            debugPrint("working");
            _questionController.clear();
            _op1Controller.clear();
            _op2Controller.clear();
            _op3Controller.clear();
            _op4Controller.clear();
            _answerController.clear();
        },
        child: Icon(Icons.keyboard_arrow_up),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }

  Widget _submitButton() {
    return IconButton(
        icon: Icon(Icons.arrow_upward),
        onPressed: () {
          // if (_question.isNotEmpty &&
          //     op1.isNotEmpty &&
          //     op2.isNotEmpty &&
          //     op3.isNotEmpty &&
          //     op4.isNotEmpty &&
          //     answer.isNotEmpty) {
            debugPrint("Clicked");
            _firestore.collection("questions").add({
              'question': _question,
              'op1': op1,
              'op2': op2,
              'op3': op3,
              'op4': op4,
              'answer': answer,
            });
            debugPrint("working");
            _questionController.clear();
            _op1Controller.clear();
            _op2Controller.clear();
            _op3Controller.clear();
            _op4Controller.clear();
            _answerController.clear();
//           } else {
//             final snackBar =
//                 SnackBar(content: Text('please fill in all the fields'));

// // Find the Scaffold in the widget tree and use it to show a SnackBar.
//             Scaffold.of(context).showSnackBar(snackBar);
//           }
        }
      );
  }

  Widget _modifiedBody() {
    return ClipPath(
      clipper: BodyClipper(),
      child: Center(
        child: Container(
          height: 620,
          width: 420,
          padding: EdgeInsets.all(10),
          color: Colors.white30,
          child: Center(
            child: Container(
              color: Colors.white,
              height: 450,
              width: 400,
              child: ListView(
                  padding: EdgeInsets.all(8),
                  reverse: true,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Questionare",
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        Theme(
                          data: Theme.of(context).copyWith(
                            primaryColor: Colors.orangeAccent,
                          ),
                          child: TextField(
                              controller: _questionController,
                              onChanged: (value) {
                                setState(() {
                                  _question = value;
                                });
                              },
                              cursorColor: Colors.orangeAccent,
                              maxLines: 5,
                              minLines: 1,
                              decoration: InputDecoration(
                                icon: Icon(Icons.receipt),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: new BorderSide(
                                        color: Colors.orangeAccent)),
                                labelText: 'Questions',
                                labelStyle: TextStyle(color: Colors.black),
                                focusColor: Colors.orangeAccent,
                              )),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                width: 100,
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    primaryColor: Colors.orangeAccent,
                                  ),
                                  child: TextField(
                                      controller: _op1Controller,
                                      onChanged: (value) {
                                        setState(() {
                                          op1 = value;
                                        });
                                      },
                                      cursorColor: Colors.orangeAccent,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        icon:
                                            Icon(Icons.check_box_outline_blank),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: new BorderSide(
                                                color: Colors.orangeAccent)),
                                        labelText: 'Option 1',
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        focusColor: Colors.orangeAccent,
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Container(
                                width: 100,
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    primaryColor: Colors.orangeAccent,
                                  ),
                                  child: TextField(
                                      controller: _op2Controller,
                                      onChanged: (value) {
                                        setState(() {
                                          op2 = value;
                                        });
                                      },
                                      cursorColor: Colors.orangeAccent,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        icon:
                                            Icon(Icons.check_box_outline_blank),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: new BorderSide(
                                                color: Colors.orangeAccent)),
                                        labelText: 'Option 2',
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        focusColor: Colors.orangeAccent,
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                width: 100,
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    primaryColor: Colors.orangeAccent,
                                  ),
                                  child: TextField(
                                      controller: _op3Controller,
                                      onChanged: (value) {
                                        setState(() {
                                          op3 = value;
                                        });
                                      },
                                      cursorColor: Colors.orangeAccent,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        icon:
                                            Icon(Icons.check_box_outline_blank),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: new BorderSide(
                                                color: Colors.orangeAccent)),
                                        labelText: 'Option 3',
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        focusColor: Colors.orangeAccent,
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Container(
                                width: 100,
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    primaryColor: Colors.orangeAccent,
                                  ),
                                  child: TextField(
                                      controller: _op4Controller,
                                      onChanged: (value) {
                                        setState(() {
                                          op4 = value;
                                        });
                                      },
                                      cursorColor: Colors.orangeAccent,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        icon:
                                            Icon(Icons.check_box_outline_blank),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: new BorderSide(
                                                color: Colors.orangeAccent)),
                                        labelText: 'Option 4',
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        focusColor: Colors.orangeAccent,
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Container(
                            width: 150,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                primaryColor: Colors.orangeAccent,
                              ),
                              child: TextField(
                                  controller: _answerController,
                                  onChanged: (value) {
                                    setState(() {
                                      answer = value;
                                    });
                                  },
                                  cursorColor: Colors.orangeAccent,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.check_box_outline_blank),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: new BorderSide(
                                            color: Colors.orangeAccent)),
                                    labelText: 'Answer',
                                    labelStyle: TextStyle(color: Colors.black),
                                    focusColor: Colors.orangeAccent,
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Container _logoutButton() {
    return Container(
      height: 40,
      width: 55,
      color: Colors.greenAccent,
      child: InkWell(
        onTap: () {
          FirebaseAuth.instance.signOut().then((value) {
            Navigator.of(this.context).pushReplacement(
                MaterialPageRoute(builder: (context) => DemoLogin()));
          }).catchError((e) {
            print(e);
          });
          //debugPrint("logout");
        },
        child: Text("Logout"),
      ),
    );
  }
}

class BodyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(225, 0);
    path.lineTo(200, 80);
    path.lineTo(175, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
