import 'package:flutter/material.dart';
import 'package:quizzler/quiz_memory.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizMemory quizMemory = QuizMemory();

void main() {
  runApp(const quizzlerApp());
}

class quizzlerApp extends StatelessWidget {
  const quizzlerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding (
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon> scoreKeeper = [];

  void checkAnswer (bool userPickedAnswer) {
    //check if the user gets correct answer
    bool correctAnswer = quizMemory.getCorrectAnswer();
    
    setState(() {
      // check if we've reached the end of the quiz. 
      if (quizMemory.isFinished() == true) {
        
        // show an alert using rFlutter_alert,
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'Question completed.',
          style: AlertStyle(
            isCloseButton: true,
            isOverlayTapDismiss: false, // This disables the outside click
          ),
        ).show();

        // reset the question to the beginning
        quizMemory.reset();

        // then empty out the scoreKeeper.
        scoreKeeper = [];
      }

      //If we've not reached the end, ELSE do the answer checking steps below 
      else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizMemory.nextQuestion();
      }
    });

  }
  
  @override
   Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizMemory.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ), 
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              //the user picked true
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ), 
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              //the user picked false
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}