// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:week3lab/page_answer/answer_portal.dart';
import 'package:week3lab/page_answer/answer1.dart';
import 'package:week3lab/page_answer/answer2.dart';
import 'package:week3lab/page_answer/answer3.dart';
import 'package:week3lab/page_answer/answer4.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('My Answer',
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.orange,
        ),
        body: Container(
          color: Colors.lightBlue[50],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAnswerButton(context, 'Answer1', Answer1()),
                const SizedBox(height: 5),
                _buildAnswerButton(context, 'Answer2', Answer2()),
                const SizedBox(height: 5),
                _buildAnswerButton(context, 'Answer3', Answer3()),
                const SizedBox(height: 5),
                _buildAnswerButton(context, 'Answer4', Answer4()),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _buildAnswerButton(BuildContext context, String text, Widget page) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          textStyle: TextStyle(fontSize: 14),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.deepPurple[200]),
        ),
      ),
    );
  }
}

