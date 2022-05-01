import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:quiz_app/Model/answer_model.dart';
import 'package:quiz_app/Model/question_model.dart';
import 'package:quiz_app/Pages/result_page.dart';
import 'package:quiz_app/Shared/constants.dart';
import 'package:quiz_app/Shared/custom_dialog.dart';
import '../shared/customRoute.dart';

class GetJson extends StatelessWidget {
  // accept the examTopic as a parameter
  String examTopic;
  DateTime examFinalDate;

  GetJson({required this.examTopic, required this.examFinalDate});

  // the give the exact path of json file
  String assetToLoad="";

  // a function sets the asset to a particular JSON file and opens the JSON
  setAsset() {
    //PHYSICS
    if (examTopic == "Physics1") {
      assetToLoad = "assets/physics/Physics1.json";
    } else if (examTopic == "Physics2") {
      assetToLoad = "assets/physics/Physics2.json";
    } else if (examTopic == "Physics3") {
      assetToLoad = "assets/physics/Physics3.json";
    } else if (examTopic == "Physics4") {
      assetToLoad = "assets/physics/Physics4.json";
    }
    //ENGLISH
    else if (examTopic == "English1") {
      assetToLoad = "assets/english/English1.json";
    } else if (examTopic == "English2") {
      assetToLoad = "assets/english/English2.json";
    } else if (examTopic == "English3") {
      assetToLoad = "assets/english/English3.json";
    }else if (examTopic == "English4") {
      assetToLoad = "assets/english/English4.json";
    }
    //COMPUTER
    else if (examTopic == "Computer1") {
      assetToLoad = "assets/computer/Computer1.json";
    }else if (examTopic == "Computer2") {
      assetToLoad = "assets/computer/Computer2.json";
    }else if (examTopic == "Computer3") {
      assetToLoad = "assets/computer/Computer3.json";
    }else if (examTopic == "Computer4") {
      assetToLoad = "assets/computer/Computer4.json";
    }
    //GEOGRAPHY
    else if (examTopic == "Geography1") {
      assetToLoad = "assets/geography/Geography1.json";
    }else if (examTopic == "Geography2") {
      assetToLoad = "assets/geography/Geography2.json";
    }else if (examTopic == "Geography3") {
      assetToLoad = "assets/geography/Geography3.json";
    }else if (examTopic == "Geography4") {
      assetToLoad = "assets/geography/Geography4.json";
    }
    //HISTORY
    else if (examTopic == "History1") {
      assetToLoad = "assets/history/History1.json";
    }else if (examTopic == "History2") {
      assetToLoad = "assets/history/History2.json";
    }else if (examTopic == "History3") {
      assetToLoad = "assets/history/History3.json";
    }else if (examTopic == "History4") {
      assetToLoad = "assets/history/History4.json";
    }
    //CHEMISTRY
    else if (examTopic == "Chemistry1") {
      assetToLoad = "assets/chemistry/Chemistry1.json";
    }else if (examTopic == "Chemistry2") {
      assetToLoad = "assets/chemistry/Chemistry2.json";
    }else if (examTopic == "Chemistry3") {
      assetToLoad = "assets/chemistry/Chemistry3.json";
    }else if (examTopic == "Chemistry4") {
      assetToLoad = "assets/chemistry/Chemistry4.json";
    }
    //BIOLOGY
    else if (examTopic == "Biology1") {
      assetToLoad = "assets/biology/Biology1.json";
    }else if (examTopic == "Biology2") {
      assetToLoad = "assets/biology/Biology2.json";
    }else if (examTopic == "Biology3") {
      assetToLoad = "assets/biology/Biology3.json";
    }else if (examTopic == "Biology4") {
      assetToLoad = "assets/biology/Biology4.json";
    }
    else {
      assetToLoad = "assets/physics/Physics1.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    // to set the exam based on what the question set was selected by user
    setAsset();

    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(assetToLoad, cache: false),
      builder: (context, snapshot) {

        if (snapshot.data == null || snapshot.data.toString().isEmpty) {
          return Scaffold(
            body: Center(
                child: CircularProgressIndicator()
            ),
          );
        }
        // getting the data from json and storing into the myData list
        List myData = json.decode(snapshot.data.toString());
        return QuizPage(
          mydata: myData,
          examFinalDate: examFinalDate,
          heading: examTopic
            .replaceAll('1', "")
            .replaceAll("2", "")
            .replaceAll("3", "")
            .replaceAll("4", "")
            .replaceAll("5", "")
            .replaceAll("6", "")
            .replaceAll("7", "")
            .replaceAll("8", "")
            .replaceAll("9", "")
            .replaceAll("0", ""),
        );
      },
    );
  }
}

class QuizPage extends StatefulWidget {

  final List mydata;
  final String heading;
  final DateTime examFinalDate;
  QuizPage({required this.mydata, required this.heading, required this.examFinalDate});

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {

  // question number index
  int j = 0;

  //question model list to store
  List<QuestionModel> questionsModel = [];

  late Timer totalTime;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;

  late Timer time;
  int timer = 0;
  String showTimer = "0";
  PageController controller = PageController();

  @override
  void initState() {
    startTimer();
    startTotalTimer();
    jsonToModel();
    super.initState();
    controller.addListener(() {
      setState(() {
        questionsModel[j].timeSpent = timer;
        j = controller.page!.toInt();
        if(questionsModel[j].timeSpent==0){
          timer=0;
        }else{
          timer = questionsModel[j].timeSpent;
        }
      });
    });
  }

  @override
  void dispose() {
    time.cancel();
    totalTime.cancel();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {
        return askDialog(context, "Do you really want to exit?");
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.black26,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: height(context)*0.05,
                width: width(context)*0.3,
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(7)
                ),
                child: Center(
                  child: Text(
                    "${hours.toString()}:${minutes.toString()}:${seconds.toString()}",
                    style: TextStyle(
                      fontSize: 15
                    ),
                  )
                ),
              ),
              Container(
                height: height(context)*0.063,
                width: width(context)*0.13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white54
                ),
                child: Center(
                  child: Text(
                    showTimer,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black
                    ),
                  )
                ),
              ),
            ],
          ),
          leadingWidth: 45,
          actions: [
            IconButton(
              icon: Icon(
                Icons.apps,
                size: 35,
                color: Colors.black87,
              ),
              tooltip: "All Questions",
              onPressed: () async{
                //to get the questionNumber from grid icon so that we can go to that question
                int questionNumber = await allQuestionsList(context, widget.mydata[0].length, questionsModel) ?? j;
                //storing the time spent on this particular question before jumping to the new question tapped from grid
                setState(() {
                  questionsModel[j].timeSpent = timer;
                });
                //jumping to the new question
                controller.animateToPage(questionNumber, duration: Duration(milliseconds: 400), curve: Curves.easeIn);
                //getting the new questionNumber and storing it into the j variable as its our question number index
                setState(() {
                  j = questionNumber;
                });
                //after jumping to the question, set the timer (to show or reflect on the page) from the previously stored time spent
                setState(() {
                  if(questionsModel[j].timeSpent==0){
                    timer=0;
                    // questionsModel[j].timeSpent = timer;
                  }else{
                    timer = questionsModel[j].timeSpent;
                  }
                });
              },
            ),
          ],
          leading: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ),
        bottomNavigationBar: Container(
          color: Colors.black54,
          padding: EdgeInsets.all(7),
          child: Row(
            children: [
              Row(
                children: [
                  SizedBox(width: 5,),
                  GestureDetector(
                    child: Container(
                      height: height(context)*0.06,
                      width: width(context)*0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white54
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back_ios),
                            Text("Previous"),
                          ],
                        )
                      ),
                    ),
                    onTap: () {
                      previousQuestion();
                    },
                  ),
                  SizedBox(width: 15,),
                  GestureDetector(
                    child: Container(
                      height: height(context)*0.06,
                      width: width(context)*0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white54
                      ),
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Next"),
                              Icon(Icons.arrow_forward_ios_outlined),
                            ],
                          )
                      ),
                    ),
                    onTap: () {
                      nextQuestion();
                    },
                  ),
                ],
              ),
              // Spacer(),
              IconButton(
                icon: Icon(
                  Icons.cancel,
                  size: 30,
                  color: Colors.white70,
                ),
                tooltip: "Does Not Want To Attempt",
                onPressed: () {
                  setState(() {
                    questionsModel[j].questionStatus = QuestionStatus.does_not_want_to_attempt;
                    questionsModel[j].answerModel.selectedOption = Option.none;
                  });
                  showMessage("Does Not Want To Attempt");
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.flag,
                  size: 30,
                  color: Colors.white70,
                ),
                tooltip: "Mark For Review",
                onPressed: () {
                  if(questionsModel[j].questionStatus==QuestionStatus.attempted){
                    setState(() {
                      questionsModel[j].questionStatus = QuestionStatus.answered_but_marked_for_review;
                    });
                  }else if(questionsModel[j].questionStatus==QuestionStatus.not_attempted){
                    setState(() {
                      questionsModel[j].questionStatus = QuestionStatus.unanswered_and_marked_for_review;
                    });
                  }
                  showMessage("Marked For Review");
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.assignment_turned_in_rounded,
                  size: 30,
                  color: Colors.white70,
                ),
                tooltip: "Submit",
                onPressed: () async{
                  bool isSubmitting = await askDialog(context, "Do you really want to submit?");
                  if(isSubmitting){
                    questionsModel[j].timeSpent = timer;
                    Navigator.of(context).pushReplacement(
                      CustomRoute(
                        page: ResultPage(
                          questionsModel: questionsModel,
                          totalTimeSpent: "${hours.toString()}:${minutes.toString()}:${seconds.toString()}"
                        )
                      )
                    );
                  }
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: height(context)*0.1,
                color: Colors.black45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "5th",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800
                                ),
                              ),
                              Text(
                                "Your Rank",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "You have passed 4 contestants",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            height: 20,
                            width: width(context)*0.35,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height(context)*0.7,
                width: width(context),
                child: PageView.builder(
                  itemCount: questionsModel.length,
                  controller: controller,
                  itemBuilder: (context, int index) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: height(context)*0.66,
                          width: width(context),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        ),
                        Container(
                          height: height(context)*0.635,
                          width: width(context),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        ),
                        Container(
                          height: height(context)*0.6,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: ListView(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0, left: 25.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Question ${(j+1).toString()}",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ]
                                    )
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                                alignment: Alignment.bottomLeft,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 3.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: myBlack,
                                    ),
                                    height: height(context)*0.20,
                                    width: width(context)*0.9,
                                    child: Center(
                                      child: Text(
                                        questionsModel[j].question,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    choiceButton(questionsModel[j].answerModel.options[0], Option.a),
                                    choiceButton(questionsModel[j].answerModel.options[1], Option.b),
                                    choiceButton(questionsModel[j].answerModel.options[2], Option.c),
                                    choiceButton(questionsModel[j].answerModel.options[3], Option.d),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // to go to the previous question
  void previousQuestion() {
    //storing the time spent on this particular question before jumping to the new question tapped from grid
    setState(() {
      questionsModel[j].timeSpent = timer;
    });
    controller.animateToPage(controller.page!.toInt() -1,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn
    );
    setState(() {
      if (j < 9) {
        if(j==0){
          // j=9;
        }else{
          j--;
        }
      }else {
        j--;
      }
    });
    time.cancel();
    startTimer();
    //after jumping to the question, set the timer (to show or reflect on the page) from the previously stored time spent
    setState(() {
      if(questionsModel[j].timeSpent==0){
        timer=0;
      }else{
        timer = questionsModel[j].timeSpent;
      }
    });
  }

  // to go to the next question
  void nextQuestion() {
    //storing the time spent on this particular question before jumping to the new question tapped from grid
    setState(() {
      questionsModel[j].timeSpent = timer;
    });
    controller.animateToPage(controller.page!.toInt() + 1,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn
    );
    setState(() {
      if (j < 9) {
        j++;
      }else {
        // j=0;
      }
    });
    time.cancel();
    startTimer();
    //after jumping to the question, set the timer (to show or reflect on the page) from the previously stored time spent
    setState(() {
      if(questionsModel[j].timeSpent==0){
        timer=0;
      }else{
        timer = questionsModel[j].timeSpent;
      }
    });
  }

  //to check the answer
  void checkAnswer(String option) {
    if(option==questionsModel[j].answerModel.correctAnswer){
      setState(() {
        questionsModel[j].isCorrect = true;
      });
    } else {
      setState(() {
        questionsModel[j].isCorrect = false;
      });
    }
  }

  // timer on each question
  void startTimer() async {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        time = t;
        if (timer > 9999) {
          t.cancel();
          nextQuestion();
        }else{
          timer = timer + 1;
        }
        showTimer = timer.toString();
      });
    });
  }

  //starting the total timer
  void startTotalTimer() {
    const oneSec = const Duration(seconds: 1);
    totalTime = new Timer.periodic(oneSec, (Timer newTimer){
      setState(() {
        if (seconds < 0) {
          newTimer.cancel();
        }else if(DateTime.now().isAfter(widget.examFinalDate)){
          //Test will automatically get submitted and will be over after the duration (predefined deadline) is over
          newTimer.cancel();
          questionsModel[j].timeSpent = timer;
          Navigator.of(context).pushReplacement(
              CustomRoute(
                  page: ResultPage(
                      questionsModel: questionsModel,
                      totalTimeSpent: "${hours.toString()}:${minutes.toString()}:${seconds.toString()}"
                  )
              )
          );
        } else {
          seconds = seconds + 1;
          if (seconds > 59) {
            minutes += 1;
            seconds = 0;
            if (minutes > 59) {
              hours += 1;
              minutes = 0;
            }
          }
        }
      });
    }
    );
  }

  //to get the data from json and store into the question model
  void jsonToModel(){
    for(int i=0; i<widget.mydata[0].length; i++){
      questionsModel.add(
        QuestionModel(
            question: widget.mydata[0][i.toString()],
            questionStatus: QuestionStatus.not_attempted,
            isCorrect: false,
            questionNumber: i,
            timeSpent: 0,
            answerModel: AnswerModel(
              selectedOption: Option.none,
              correctAnswer: widget.mydata[2][i.toString()],
              options: [
                widget.mydata[1][i.toString()]["a"],
                widget.mydata[1][i.toString()]["b"],
                widget.mydata[1][i.toString()]["c"],
                widget.mydata[1][i.toString()]["d"]
              ],
            )
        ),
      );
    }
  }

  Future<dynamic> allQuestionsList(BuildContext context, int questionsLength, List<QuestionModel> questionsModel) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black12,
        builder: (context)=> BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: CustomDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
            ),
            elevation: 24.0,
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            child: Container(
                height: height(context)*0.7,
                width: width(context)*0.9,
                margin: const EdgeInsets.all(8.0),
                // color: Colors.red,
                child:  GridView.builder(
                  itemCount: questionsLength,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context, questionsModel[index].questionNumber);
                      },
                      child: Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        color: questionsStatusColors[questionsModel[index].questionStatus],
                        child: Container(
                            alignment: Alignment.center,
                            // color: Colors.red,
                            child: Text((questionsModel[index].questionNumber+1).toString())
                        ),
                      ),
                    );
                  },
                )
            ),
          ),
        )
    );
  }

  Widget choiceButton(String option, Option selectedOption){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Radio<Option>(
            value: selectedOption,
            groupValue: questionsModel[j].answerModel.selectedOption,
            onChanged: (value){
              setState(() {
                questionsModel[j].questionStatus = QuestionStatus.attempted;
                questionsModel[j].answerModel.selectedOption = selectedOption;
              });
              checkAnswer(option);
            },
          ),
          Text(
            option,
            style: TextStyle(
              color:  Colors.black87,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }

}
