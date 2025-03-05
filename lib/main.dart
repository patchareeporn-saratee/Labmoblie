import 'package:flutter/material.dart';
//import '../Homework2/air_quality.dart';
//import 'package:week3lab/products/product_api.dart';
import '../traffi_clight/trafficlight.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
         home: TrafficLightScreen(),
    );
  }
}

  
  