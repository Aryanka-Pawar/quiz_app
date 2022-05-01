class ExamModel{
  int duration;
  final String questionSet;
  final DateTime examInitialDate;
  final DateTime examFinalDate;
  ExamModel({
    required this.duration,
    required this.questionSet,
    required this.examInitialDate,
    required this.examFinalDate,
  });
}
