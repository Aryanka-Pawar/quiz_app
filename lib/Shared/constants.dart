import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/Model/question_model.dart';
import 'dart:ui';
import 'custom_dialog.dart';

double height(context) {
  var myHeight = MediaQuery.of(context).size.height;
  return myHeight;
}

double width(context) {
  var myWidth = MediaQuery.of(context).size.width;
  return myWidth;
}

final myBlack = Color(0xff263d54);

Map<QuestionStatus, Color> questionsStatusColors = {
  QuestionStatus.attempted: Colors.green,
  QuestionStatus.answered_but_marked_for_review: Colors.yellow,
  QuestionStatus.unanswered_and_marked_for_review: Colors.orange,
  QuestionStatus.not_attempted: Colors.grey,
  QuestionStatus.does_not_want_to_attempt: Colors.pink,
};

enum Option{a, b, c, d, none}

enum QuestionStatus{
  attempted,
  answered_but_marked_for_review,
  unanswered_and_marked_for_review,
  not_attempted,
  does_not_want_to_attempt
}


Future<bool> askDialog(context, String message) async{
  return (await showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        title: Text(
          message,
          style: TextStyle(
              fontSize: 15.0
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            shape: StadiumBorder(),
            elevation: 1.0,
            color: Colors.white,
            child: Text(
              "Yes",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12
              ),
            ),
            splashColor: Colors.blue[100],
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.pop(context,true);
            },
          ),
          MaterialButton(
            shape: StadiumBorder(),
            elevation: 3.0,
            color: Colors.white,
            child: Text(
              "No",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12
              ),
            ),
            splashColor: Colors.blue[100],
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.pop(context,false);  //if its true then it will exit
            },
          ),
        ],
      )
  ))??false;
}

const textStyleForUserName = TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 13,
    fontFamily: 'kufam',
    color: Colors.black
);

const textStyleForPageHeading = TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'DM Sans'
);

void showMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.white,
      textColor: myBlack,
      fontSize: 11.0
  );
}