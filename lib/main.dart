import 'package:bmi_calc/bmi_provider.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:bmi_calc/bmi_home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context)=> BmiProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      title: 'BMI Calculator',
      home: const BmiHome(),
    );
  }
}
