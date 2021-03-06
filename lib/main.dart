import 'package:flutter/material.dart';
import 'quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Icon iconTrue = Icon(
    Icons.check,
    color: Colors.green,
  );
  Icon iconFalse = Icon(
    Icons.close,
    color: Colors.red,
  );
  List<Icon> listIcons = [];

  QuizBrain quizBrain = QuizBrain();

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
                quizBrain.getQuestionText(),
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
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (quizBrain.getQuestionAnswer() == true) {
                    listIcons.add(iconTrue);
                  } else {
                    listIcons.add(iconFalse);
                  }
                  isNextQuestion(quizBrain.nextQuestionOrAlert());
                });
                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (quizBrain.getQuestionAnswer() == false) {
                    listIcons.add(iconTrue);
                  } else {
                    listIcons.add(iconFalse);
                  }
                  isNextQuestion(quizBrain.nextQuestionOrAlert());
                });
                //The user picked false.
              },
            ),
          ),
        ),
        Row(
          children: listIcons,
        )
      ],
    );
  }

//Est ce la fin du quiz ? si oui j'affiche une alerte et reset le compteur à 0
  void isNextQuestion(bool nextQuestionOrAlert) {
    if (nextQuestionOrAlert) {
      Alert(
          context: context,
          title: "Fin du Quiz",
          desc: "Plus de question !!",
          buttons: [
            DialogButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context))
          ]).show();
      listIcons = [];
    }
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
