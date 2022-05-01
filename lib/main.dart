import 'package:flutter/material.dart';
import 'package:quiz_app/Model/exam_model.dart';
import 'package:quiz_app/Pages/all_quiz_page.dart';
import 'package:quiz_app/Pages/quiz_page.dart';
import 'package:quiz_app/Shared/constants.dart';
import 'package:quiz_app/Shared/custom_appbar.dart';
import 'shared/customButton.dart';
import 'shared/customRoute.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Exam Tests'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //Exam model initialization
  ExamModel examModel =  ExamModel(duration: 0, questionSet: "English1", examInitialDate: DateTime.now(), examFinalDate: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customBar(widget.title, context, Colors.black, showBackButton: false, color: Colors.white),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (examModel.duration!=0) ? Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text("Exam Topic: ${examModel.questionSet.toString()}"),
                  Text("Staring Date And Time: ${examModel.examInitialDate.toString().substring(0, 19)}"),
                  Text("Ending Date And Time: ${examModel.examFinalDate.toString().substring(0, 19)}"),
                  Text("Duration: ${examModel.duration.toString()} min"),
                  CustomButton(
                    text: 'Take Exam!',
                    minWidth: width(context)*0.40,
                    height: 40,
                    color: Colors.black,
                    onPressed: (){
                      // to check if user should go to the exam page based on date and time of exam
                      if(DateTime.now().isAfter(examModel.examInitialDate) && DateTime.now().isBefore(examModel.examFinalDate)){
                        Navigator.of(context).push(CustomRoute(page: GetJson(examTopic: examModel.questionSet, examFinalDate: examModel.examFinalDate)));
                      }else{
                        showMessage("See exam date and time.\nYou can not take test right now!");
                      }
                    },
                  ),
                ],
              ),
            ) : Text('You have not selected any exam.'),
            // DatePickerWidget(),
            // TimePickerWidget(),
            // DateRangePickerWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExam,
        tooltip: 'Add Exam',
        backgroundColor: Colors.white,
        child: Icon(Icons.add, color: Colors.black,),
      ),
    );
  }

  //add exam function to add new exam
  void _addExam() async{
    ExamModel newExamModel = examModel;
    newExamModel = await Navigator.of(context).push(CustomRoute(page: AllQuizPage()));
    setState(() {
      examModel = newExamModel;
    });
    print(examModel);
  }
}
