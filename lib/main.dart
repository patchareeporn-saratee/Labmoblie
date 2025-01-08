import 'package:flutter/material.dart';
import 'package:week3lab/page_answer/answer_portal.dart';
import 'package:week3lab/page_answer/answer1.dart';
import 'package:week3lab/page_answer/answer2.dart';
import 'package:week3lab/page_answer/answer3.dart';
import 'package:week3lab/page_answer/answer4.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routes: {HomePage.routeName: (context) => const HomePage()},
      initialRoute: HomePage.routeName,
    );
  }
}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage());
  }
