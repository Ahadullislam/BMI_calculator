import 'package:flutter/material.dart';

const backgroundcolor = Colors.indigo;

const txtlabestyle = TextStyle(
  color: Colors.white,
  fontSize: 30,
);

const txtvaluestyle = TextStyle(
  color: Colors.white,
  fontSize: 30,
);

abstract final class BMI {
  static const String uwsevere = 'Underweight (Severe thinness)';
  static const String uwmoderate = 'Underweight (Moderate thinness)';
  static const String uwmild = 'Underweight (Mild thinness)';
  static const String  normal = 'Normal';
  static const String owpre = 'Overweight (Pre-obese)';
  static const String obese_1 = 'Obese (Class I)';
  static const String obese_2 = 'Obese (Class II)';
  static const String obese_3 = 'Obese (Class III)';
}

enum BMIUnit {
  m, ft, kg, lb,
}