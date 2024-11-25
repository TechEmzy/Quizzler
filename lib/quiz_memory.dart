import 'package:quizzler/question.dart';

class QuizMemory{

  //this is to keep track of the question numbers
  int _questionIndex = 0;

  List<Question> _questionList = [
    Question("Flutter is developed by Facebook.", false),
    Question("Flutter allows for both Android and iOS app development using a single codebase.", true),
    Question( "Flutter uses JavaScript as its primary programming language.", false),
    Question( "Flutter's hot reload feature allows developers to see changes in real-time without restarting the app.", true),
    Question( "Widgets in Flutter are immutable.", true),
    Question( "Flutter does not support web and desktop applications.", false),
    Question( "In Flutter, everything is a widget.", true),
    Question( "Flutter apps compile to native ARM code, which improves performance.", true),
    Question( "The Flutter framework does not include a rich set of pre-designed widgets.", false),
    Question( "Flutter's primary method for layout is the use of constraints and flex properties.", true),
  ];

  void nextQuestion() {
    // -1 will stop our app from moving to the next question when it gets to the last question
    if (_questionIndex < _questionList.length - 1) {
      _questionIndex++;
    }
  }

  String getQuestionText(){
    return _questionList[_questionIndex].questionText;
  }

  bool getCorrectAnswer(){
    return _questionList[_questionIndex].questionAnswer;
  }

  // check to see if it has reached the last question. 
  // it should return 'true' if we have reached the last question, else return false if we are not yet to the last question.
  bool isFinished(){
    if (_questionIndex >= _questionList.length - 1){
      print('Return true');
      return true;
    } else {
      return false;
    }
  }

  // this method sets the questionNumber back to 0.
  void reset() {
    _questionIndex = 0;
  }
}