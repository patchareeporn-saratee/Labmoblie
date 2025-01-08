// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class Answer1 extends StatefulWidget {
  const Answer1({Key? key}) : super(key: key);

  @override
  State<Answer1> createState() => _Answer1State();
}

class _Answer1State extends State<Answer1>{
  var _subPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: const Text('Grid Layout',
                  style: TextStyle(color: Colors.black),
              )
          ),
          backgroundColor: Colors.orange,
          actions: [
            _subPageIndex == 0
                ? IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back),
            )
                : SizedBox.shrink(),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // แถวที่ 1
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
                const SizedBox(width: 20),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                ),
                const SizedBox(width: 20),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // แถวที่ 2
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.orange,
                ),
                const SizedBox(width: 20),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.purple,
                ),
                const SizedBox(width: 20),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.yellow,
                ),
              ],
            ),
          ],
        ),
    );
  }
}
