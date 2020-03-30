import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hire_manager/main.dart';

class DetailQuestions extends StatefulWidget {
  final DocumentSnapshot question;
  DetailQuestions(this.question);
  @override
  _DetailQuestionsState createState() => _DetailQuestionsState();
}

class _DetailQuestionsState extends State<DetailQuestions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 80,left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "The Question ?",
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(
                height: 10,
              ),
              _showQuestion(widget.question.data["question"]),
              SizedBox(
                height: 20,
              ),
              _showOption(widget.question.data["op1"], 1),
              SizedBox(
                height: 20,
              ),
              _showOption(widget.question.data["op2"], 2),
              SizedBox(
                height: 20,
              ),
              _showOption(widget.question.data["op3"], 3),
              SizedBox(
                height: 20,
              ),
              _showOption(widget.question.data["op4"], 4),
              SizedBox(
                height: 20,
              ),
              _showAnswer(widget.question.data["answer"]),
              SizedBox(
                height: 20,
              ),
              Text("Posted By ${widget.question.data["email"]} "),
            ],
          ),
        ));
  }

  Widget _showQuestion(String question) {
    return Container(
      //width: 500,
      padding: EdgeInsets.only(top: 10, left: 50, right: 50, bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(15)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.question_answer),
          SizedBox(
            width: 20,
          ),
          Expanded(child: Text('''$question''')),
        ],
      ),
    );
  }

  Widget _showOption(String option, int index) {
    return Container(
      //width: 500,
      padding: EdgeInsets.only(top: 10, left: 50, right: 50, bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(15)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Option $index: "),
          SizedBox(
            width: 20,
          ),
          Expanded(child: Text(''' $option''')),
        ],
      ),
    );
  }

  Widget _showAnswer(String answer) {
    return Container(
      //width: 500,
      padding: EdgeInsets.only(top: 10, left: 50, right: 50, bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(15)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.arrow_right,
            size: 50,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(child: Text('''  $answer''')),
        ],
      ),
    );
  }
}
