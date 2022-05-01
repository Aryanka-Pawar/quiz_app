import 'package:flutter/material.dart';
import 'package:quiz_app/Model/exam_model.dart';
import 'constants.dart';

PreferredSizeWidget customBar(String pageTitle,
    BuildContext context,
    Color textColor,
    {required Color color, bool showBackButton = true, bool isQuestionAnswerPage = false, int questionAnswerLength = 0}) {
  return AppBar(
    elevation: 0.0,
    brightness: Brightness.light,
    backgroundColor: color,
    title: Text(
        pageTitle,
        style: textStyleForPageHeading.apply(color: textColor)
    ),
    leadingWidth: showBackButton ? 60 : 1,
    leading: showBackButton ? Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        shadowColor: Colors.black54,
        color: color == myBlack ? Color(0xff3a5978) : Colors.white,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: textColor,
          ),
          onPressed: () {
            ExamModel examModel = ExamModel(
              duration: 0,
              questionSet: "English1",
              examInitialDate: DateTime.now(),
              examFinalDate: DateTime.now(),
            );
            Navigator.pop(context, examModel);
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
    ) : SizedBox(width: 1),
    actions: [
      isQuestionAnswerPage ?  Padding(
        padding: const EdgeInsets.only(right: 8.0, top: 25),
        child: Text(
            "Total: ${questionAnswerLength.toString()}",
            style: textStyleForUserName
        ),
      ) : SizedBox(width: 1),
    ],
  );
}
