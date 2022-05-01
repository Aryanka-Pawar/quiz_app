import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/Model/exam_model.dart';
import 'package:quiz_app/Shared/custom_appbar.dart';
import '../shared/constants.dart';


class AllQuizPage extends StatefulWidget {
  @override
  _AllQuizPageState createState() => _AllQuizPageState();
}

class _AllQuizPageState extends State<AllQuizPage> {

  DateTime initialDateTime = DateTime.now();
  DateTime finalDateTime = DateTime.now();
  int timeDuration = 10;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        ExamModel examModel = ExamModel(
            duration: 0,
            questionSet: "English1",
            examInitialDate: DateTime.now(),
            examFinalDate: DateTime.now(),
        );
        Navigator.pop(context, examModel);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customBar("Quiz", context, Colors.black, showBackButton: true, color: Colors.white),
        body: Container(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Competitive exams",
                  style: TextStyle(
                      color: myBlack,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DM Sans'
                  ),
                ),
              ),
              quizHeading("English"),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.21,
                child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      quizCard(Colors.blueAccent, Colors.blueAccent, Colors.blueAccent, "English\nGrammar", context, "English1"),
                      quizCard(Colors.blueAccent, Colors.blueAccent, Colors.blueAccent, "English\nVoice", context, "English2"),
                      quizCard(Colors.blueAccent, Colors.blueAccent, Colors.blueAccent, "English\nAntonyms",  context, "English3"),
                      quizCard(Colors.blueAccent, Colors.blueAccent, Colors.blueAccent, "English\nSentence\nCompletion", context, "English4"),
                    ]
                ),
              ),
              quizHeading("Computer Science"),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.21,
                child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      quizCard(Color.fromRGBO(194, 197, 255, 0.5) , Color.fromRGBO(143, 148, 251, 0.5), Color.fromRGBO(194, 197, 255, 0.5), "Computer\nHardware", context, "Computer1"),
                      quizCard(Color.fromRGBO(194, 197, 255, 0.7) , Color.fromRGBO(143, 148, 251, 0.7), Color.fromRGBO(194, 197, 255, 0.7), "Disk Operating\nSystem (DOS)", context, "Computer2"),
                      quizCard(Color.fromRGBO(194, 197, 255, 1) , Color.fromRGBO(143, 148, 251, 1), Color.fromRGBO(194, 197, 255, 1), "Artificial\nIntelligence", context, "Computer3"),
                      quizCard(Color.fromRGBO(194, 197, 255, 1) , Color.fromRGBO(143, 148, 251, 1), Color.fromRGBO(194, 197, 255, 1), "Database\nSystems", context, "Computer4"),
                    ]
                ),
              ),
              quizHeading("Physics"),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.21,
                child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      quizCard(Colors.redAccent, Colors.redAccent, Colors.redAccent, "Units,\nmeasurement\nand vectors", context, "Physics1"),
                      quizCard(Colors.redAccent, Colors.redAccent, Colors.redAccent, "Acceleration\ndue to Gravity", context, "Physics2"),
                      quizCard(Colors.redAccent, Colors.redAccent, Colors.redAccent, "Motion\nin a Plane", context, "Physics3"),
                      quizCard(Colors.redAccent, Colors.redAccent, Colors.redAccent, "Work,\nEnergy\nand Power", context, "Physics4"),
                    ]
                ),
              ),
              quizHeading("Geography"),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.21,
                child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      quizCard(Colors.cyan, Colors.cyan, Colors.cyan, "Indian\nGeography",  context, "Geography1"),
                      quizCard(Colors.cyan, Colors.cyan, Colors.cyan, "Universe", context, "Geography2"),
                      quizCard(Colors.cyan, Colors.cyan, Colors.cyan, "Earth",  context, "Geography3"),
                      quizCard(Colors.cyan, Colors.cyan, Colors.cyan, "Atmosphere", context, "Geography4"),
                    ]
                ),
              ),
              quizHeading("History"),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.21,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    quizCard(Colors.lime, Colors.lime, Colors.lime, "Indian\nHistory", context, "History1"),
                    quizCard(Colors.lime, Colors.lime, Colors.lime, "Vedic\nAge",  context, "History2"),
                    quizCard(Colors.lime, Colors.lime, Colors.lime, "Ancient History,\nArt and Culture",  context, "History3"),
                    quizCard(Colors.lime, Colors.lime, Colors.lime, "Indus Valley\nCivilisation", context, "History4"),
                  ]
                ),
              ),
              quizHeading("Chemistry"),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.21,
                child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      quizCard(Colors.grey, Colors.grey, Colors.grey, "Chemical\nEngineering Basics", context, "Chemistry1"),
                      quizCard(Colors.grey, Colors.grey, Colors.grey, "Chemical\nEngineering\nThermodynamics", context, "Chemistry2"),
                      quizCard(Colors.grey, Colors.grey, Colors.grey, "Chemistry\nAtoms and\nMolecules", context, "Chemistry3"),
                      quizCard(Colors.grey, Colors.grey, Colors.grey, "Chemistry\nMetals and ores", context, "Chemistry4"),
                    ]
                ),
              ),
              quizHeading("Biology"),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.21,
                child: ListView(
                    physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    quizCard(Colors.lightGreen, Colors.lightGreen, Colors.lightGreen, "The Living\nWorld", context, "Biology1"),
                    quizCard(Colors.lightGreen, Colors.lightGreen, Colors.lightGreen, "Biological\nClassification", context, "Biology2"),
                    quizCard(Colors.lightGreen, Colors.lightGreen, Colors.lightGreen, "Animal\nKingdom",  context, "Biology3"),
                    quizCard(Colors.lightGreen, Colors.lightGreen, Colors.lightGreen, "Cell", context, "Biology4"),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //pick date, time and duration of exam
  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null)
      return;

    final time = await pickTime(context);
    if (time == null)
      return;

    setState(() {
      initialDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
    final duration = await pickDuration(context);
    if (time == null)
      return;
    timeDuration = duration.inMinutes;
    finalDateTime = DateTime(
        initialDateTime.year,
        initialDateTime.month,
        initialDateTime.day,
        initialDateTime.hour,
        initialDateTime.minute,
        initialDateTime.second
    ).add(duration);
  }
  //pick date of exam
  Future<DateTime> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: DateTime(DateTime.now().year, DateTime.now().month+0, DateTime.now().day),
      lastDate: DateTime(DateTime.now().year, DateTime.now().month+1),
    );
    if (newDate == null)
      return initialDate;
    return newDate;
  }
  //pick time of exam
  Future<TimeOfDay> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
        context: context,
        initialTime: initialDateTime != null ? TimeOfDay(hour: initialDateTime.hour, minute: initialDateTime.minute) : initialTime
    );
    if (newTime == null)
      return initialTime;
    return newTime;
  }
  //pick duration of exam
  Future<Duration> pickDuration(BuildContext context) async{
    final initialDuration = Duration(minutes: 10);
    final newDuration = await showDurationPicker(
      context: context,
      initialTime: initialDuration,
      snapToMins: 10.0,
      baseUnit: BaseUnit.minute,
    );
    print(newDuration);
    if(newDuration==null)
      return initialDuration;
    return newDuration;
  }

  Widget quizCard(Color _scolor, Color _g1color, Color _g2color, String _note, context, String json) {
    return InkWell(
      onTap: () async{
        await pickDateTime(context);
        ExamModel examModel = ExamModel(
            duration: timeDuration,
            questionSet: json,
            examInitialDate: initialDateTime,
            examFinalDate: finalDateTime
        );
        print(examModel);
        Navigator.pop(context, examModel);
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height*0.18,
        width: MediaQuery.of(context).size.width*0.6,
        margin: EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
        decoration: BoxDecoration(
            color: Colors.red,
            boxShadow: [
              BoxShadow(
                  color: _scolor,
                  blurRadius: 15.0,
                  offset: Offset(0, 5),
                  spreadRadius: 1.0
              )
            ],
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                colors: [
                  _g1color,
                  _g2color,
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft
            )
        ),
        child: Stack(
          children: <Widget>[
            Container(
              //color: Colors.red,
              height: MediaQuery.of(context).size.height*0.15,
              width: MediaQuery.of(context).size.width*0.85,
              child: Stack(
                children: [
                  Positioned(
                    left: 85,
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.30,
                      width: MediaQuery.of(context).size.width*0.55,
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          shape: BoxShape.circle
                      ),
                    ),
                  ),
                  Positioned(
                      right: 25,
                      top: 55,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 15,
                      )
                  ),
                  Positioned(
                    right: 120,
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.30,
                      width: MediaQuery.of(context).size.width*0.55,
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          shape: BoxShape.circle
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 25.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _note,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w600
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget quizHeading(String heading) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 20, bottom: 5),
      child: Text(
        heading,
        style: TextStyle(
            color: myBlack,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'DM Sans'
        ),
      ),
    );
  }
}
