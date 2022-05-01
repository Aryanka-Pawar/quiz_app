import 'package:quiz_app/Shared/constants.dart';
import 'answer_model.dart';

class QuestionModel{
  final String question;
  final int questionNumber;
  QuestionStatus questionStatus;
  bool isCorrect;
  int timeSpent;
  final AnswerModel answerModel;
  QuestionModel({
    required this.question,
    required this.questionStatus,
    required this.isCorrect,
    required this.questionNumber,
    required this.answerModel,
    required this.timeSpent,
  });
}

