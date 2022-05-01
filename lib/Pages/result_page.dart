import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quiz_app/Model/question_model.dart';
import 'package:quiz_app/Shared/constants.dart';
import '../shared/customButton.dart';

class ResultPage extends StatefulWidget {
  final List<QuestionModel> questionsModel;
  final String totalTimeSpent;
  ResultPage({required this.questionsModel, required this.totalTimeSpent});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: CustomButton(
          text: 'Continue',
          minWidth: width(context)*0.40,
          height: 40,
          color: Colors.black,
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          title: Text(
            "Total Time Spent: ${widget.totalTimeSpent}",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'Question\n Number',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)
                  )
                ),
                DataColumn(
                  label: Text(
                    'Status \n(color codes at the time of submission)',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)
                  )
                ),
                DataColumn(
                  label: Text(
                    'Correct/Incorrect',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)
                  )
                ),
                DataColumn(
                  label: Text(
                    'Time Spent on this question \n(in Seconds)',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)
                  )
                ),
                DataColumn(
                  label: Text(
                    'Marks (if correct) or, \nPenalty (if incorrect) received',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)
                  )
                ),
              ],
              rows: widget.questionsModel.map(
                ((element) => DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Text(
                        "Q${(element.questionNumber+1).toString()}",
                      )
                    ),
                    DataCell(
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: questionsStatusColors[(element.questionStatus)],
                      )
                    ),
                    DataCell(
                      Text(
                          (element.questionStatus ==QuestionStatus.attempted || element.questionStatus==QuestionStatus.answered_but_marked_for_review) ?
                          (element.isCorrect ? "Correct": "InCorrect" )  :"Not attempted"
                      )
                    ),
                    DataCell(
                      Text(
                        element.timeSpent.toString()
                      )
                    ),
                    DataCell(
                      Text(
                        (element.questionStatus ==QuestionStatus.attempted || element.questionStatus==QuestionStatus.answered_but_marked_for_review) ?
                        (element.isCorrect ? max((1000-5*element.timeSpent), 0).toString() :
                        (max((0.5*(1000-5*element.timeSpent)).toInt() ,0)*-1).toString())  :"-25" ,
                        /*(element.questionStatus == QuestionStatus.not_attempted ||
                            element.questionStatus == QuestionStatus.does_not_want_to_attempt ||
                            element.questionStatus == QuestionStatus.unanswered_and_marked_for_review) ? "-25" :
                        element.isCorrect? max((1000-5*element.timeSpent), 0).toString() :
                        (max((0.5*(1000-5*element.timeSpent)).toInt() ,0)*-1).toString(),*/
                      )
                    ),
                  ],
                )),
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}