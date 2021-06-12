import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdvancePuzzleScreen extends StatefulWidget {
  AdvancePuzzleScreen({Key key}) : super(key: key);

  @override
  _AdvancePuzzleScreenState createState() => _AdvancePuzzleScreenState();
}

class _AdvancePuzzleScreenState extends State<AdvancePuzzleScreen> {
  final puzzleContainerHeight = 40.0;
  int currentSelectedBox = 0;
  String correctAnswer = "DELHI";
  List<String> submittedAnswer = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < correctAnswer.length; i++) {
      submittedAnswer.add("*");
    }
  }

  Widget puzzleAnswerBoxContainer(String letter, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentSelectedBox = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.5),
        decoration: BoxDecoration(border: Border.all(), color: currentSelectedBox == index ? Colors.grey.shade300 : Colors.white),
        height: puzzleContainerHeight,
        width: puzzleContainerHeight,
        child: Text(letter),
      ),
    );
  }

  Widget puzzleOptionContainer(String letter) {
    return GestureDetector(
      onTap: () {
        //! menas we need to add back button
        if (letter == "!") {
          submittedAnswer[currentSelectedBox] = "*";
          /*
          //for moving current index back
          if (submittedAnswer[currentSelectedBox] == "*") {
            if (currentSelectedBox != 0) {
              currentSelectedBox--;
            }
          } else {
            submittedAnswer[currentSelectedBox] = "*";
            if (currentSelectedBox != 0) {
              currentSelectedBox--;
            }
          }
          */

          setState(() {});
        } else {
          //adding new letter
          submittedAnswer[currentSelectedBox] = letter;
          //moving box one step
          if (currentSelectedBox != submittedAnswer.length - 1) {
            currentSelectedBox++;
          }
          setState(() {});
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.5),
        decoration: BoxDecoration(border: Border.all(), color: Colors.blueAccent.shade100),
        height: puzzleContainerHeight,
        width: puzzleContainerHeight,
        child: letter == "!" ? Icon(Icons.arrow_back) : Text(letter),
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

  Widget _buildAnswerBox() {
    List<Widget> listOfWidgets = [];

    for (var i = 0; i < submittedAnswer.length; i++) {
      //adding text
      String text = submittedAnswer.isEmpty
          ? "*"
          : (submittedAnswer.length - 1) >= i
              ? submittedAnswer[i]
              : "*";

      listOfWidgets.add(puzzleAnswerBoxContainer(text, i));
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
          _buildAnswerBox(),
          SizedBox(
            height: 15.0,
          ),
          //
          _buildOptions("ARDVRENMLYUHJUKI!"), //options
          SizedBox(
            height: 15.0,
          ),
          CupertinoButton(
              child: Text("Submit"),
              onPressed: () {
                if (submittedAnswer.contains("*")) {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            content: Text("Please fill all the boxes"),
                          ));
                } else {
                  //building answer
                  String answer = "";
                  for (var i = 0; i < submittedAnswer.length; i++) {
                    answer += submittedAnswer[i];
                  }
                  if (correctAnswer == answer) {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              content: Text("Correct Answer"),
                            ));
                  } else {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              content: Text("Incorrect Answer"),
                            ));
                  }
                }
              }),
        ],
      ),
    );
  }
}
