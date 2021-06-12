import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_word_puzzle/screens/advancePuzzleScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double puzzleContainerHeight = 35.0;
  String word = "DELHI";
  String options = "HEDEYLPOHQI";
  String submittedAnswer = "";

  Widget puzzleAnswerContainer(String letter, int index) {
    return GestureDetector(
      onTap: () {
        if (letter.isNotEmpty && index == submittedAnswer.length - 1) {
          setState(() {
            //sub string make new string with given start and end indedx
            //it also includes charcter from start and end index
            submittedAnswer = submittedAnswer.substring(0, submittedAnswer.length - 1);
          });
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.5),
        decoration: BoxDecoration(border: Border.all()),
        height: puzzleContainerHeight,
        width: puzzleContainerHeight,
        child: Text(letter),
      ),
    );
  }

  Widget puzzleOptionContainer(String letter) {
    return GestureDetector(
      onTap: () {
        if (submittedAnswer.length != word.length) {
          setState(() {
            submittedAnswer += letter;
          });
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.5),
        decoration: BoxDecoration(border: Border.all(), color: Colors.blueAccent.shade100),
        height: puzzleContainerHeight,
        width: puzzleContainerHeight,
        child: Text(letter),
      ),
    );
  }

  Widget _buildOptions(String answerOptions) {
    List<Widget> listOfWidgets = [];

    for (var i = 0; i < answerOptions.length; i++) {
      listOfWidgets.add(puzzleOptionContainer(answerOptions[i]));
    }

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        child: Wrap(
          children: listOfWidgets,
        ),
      ),
    );
  }

  Widget _buildSubmittedAnswer() {
    List<Widget> listOfWidgets = [];

    for (var i = 0; i < word.length; i++) {
      if (submittedAnswer.isEmpty) {
        listOfWidgets.add(puzzleAnswerContainer("", i));
      } else if ((submittedAnswer.length - 1) >= i) {
        listOfWidgets.add(puzzleAnswerContainer(submittedAnswer[i], i));
      } else {
        listOfWidgets.add(puzzleAnswerContainer("", i));
      }
    }

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        child: Wrap(
          children: listOfWidgets,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Capital of India?"),
          SizedBox(
            height: 15.0,
          ),
          _buildSubmittedAnswer(),
          SizedBox(
            height: 15.0,
          ),
          //
          _buildOptions(options),
          SizedBox(
            height: 15.0,
          ),
          CupertinoButton(
              child: Text("Submit"),
              onPressed: () {
                if (submittedAnswer.length != word.length) {
                  return;
                }
                submittedAnswer == word
                    ? showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Text("Correct Answer"),
                            ))
                    : showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Text("Incorrect Answer"),
                            ));
              }),

          SizedBox(
            height: 15.0,
          ),

          CupertinoButton(
              child: Text("Advance"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return AdvancePuzzleScreen();
                }));
              }),
        ],
      ),
    );
  }
}
