import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hire_manager/pages/demologin.dart';
import 'package:hire_manager/pages/detail_questions.dart';
import 'package:hire_manager/pages/home_page.dart';

class AllQuestionsList extends StatefulWidget {
  @override
  _AllQuestionsListState createState() => _AllQuestionsListState();
}

class _AllQuestionsListState extends State<AllQuestionsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListData());
  }
}

class ListData extends StatefulWidget {
  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

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

  //this is to get all the
  Future getQuestions() async {
    QuerySnapshot qn = await _firestore.collection("questions").getDocuments();
    return qn.documents;
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
            future: getQuestions(),
            //stream: _firestore.collection("questions").snapshots(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.orangeAccent),
                    ),
                  ),
                );
              } else {
                return ListView.separated(
                    reverse: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 6,
                      );
                    },
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return TileView(snapshot.data[index].data["question"],
                            snapshot.data[index]);
                    });
              }
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage(1))),
        child: Icon(Icons.refresh),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}

class TileView extends StatelessWidget {
  final String text;
  final DocumentSnapshot sn;
  TileView(this.text, this.sn);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(bottom: 20),
        height: 100,
        width: 200,
        child: Center(
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.question_answer),
                SizedBox(
                  width: 25,
                ),
                Expanded(
                    child: Center(
                  child: Text(
                    '''$text''',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                )),
                CircleAvatar(
                  backgroundColor: Colors.orangeAccent,
                  child: IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailQuestions(sn)));
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
