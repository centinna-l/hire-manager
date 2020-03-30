import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:hire_manager/main.dart';
import 'package:hire_manager/pages/demologin.dart';
import 'package:hire_manager/pages/demologin.dart';
import './login_page.dart';
import 'demologin.dart';
import './question_send_page.dart';
import './all_questions_list.dart';

class HomePage extends StatefulWidget {
  int bnbv;
  HomePage(this.bnbv);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String questionText;
  String answerText;
  var _questionController = TextEditingController();
  var _answerController = TextEditingController();
  int _currentIndex = 0;
  var pages = [QuestionSendPage(), AllQuestionsList()];
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _currentIndex = widget.bnbv;
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
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            child: _modifiedAppBar(), preferredSize: Size(400, 150)),
        body: Center(
          child: pages[_currentIndex],
        ),
        bottomNavigationBar: new BottomNavigationBar(
          fixedColor: Colors.orangeAccent,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.question_answer),
                title: Text("Add Question"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                title: Text("All Questions"),
              ),
            ]),
      ),
    );
  }

  Widget _modifiedAppBar() {
    return ClipPath(
      clipper: AppBarClipper(),
      child: Container(
        margin: EdgeInsets.zero,
        height: 150,
        width: 400,
        color: Colors.orangeAccent,
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 50,
                ),
                Expanded(
                    child: Center(
                  child: Text(
                    "Hire Manager",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                )),
                _logoutButton()
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _submitButton() {
    return IconButton(
        icon: Icon(Icons.arrow_upward),
        onPressed: () {
          _firestore.collection("questions").add({
            'question': questionText,
            'answer': answerText,
          });
          _questionController.clear();
          _answerController.clear();
        });
  }

  Container _logoutButton() {
    return Container(
      height: 40,
      width: 55,
      child: Center(
        child: Card(
          color: Colors.transparent,
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            child: Center(
              child: IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.of(this.context).pushReplacement(
                          MaterialPageRoute(builder: (context) => DemoLogin()));
                    }).catchError((e) {
                      print(e);
                    });
                    //debugPrint("logout");
                  },
                  icon: Icon(
                    Icons.cancel,
                    size: 25,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height - 50);
    path.lineTo(170, size.height - 50);
    path.lineTo(195, size.height);
    path.lineTo(220, size.height - 50);
    path.lineTo(size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
