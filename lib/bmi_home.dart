import 'dart:core';

import 'package:bmi_calc/bmi_provider.dart';
import 'package:bmi_calc/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BmiHome extends StatelessWidget {
  const BmiHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 5.0),
        child: Column(
          children: [
            Consumer<BmiProvider>(
              builder: (context, provider, child) => BmiSlider(
                label: 'Height',
                unit: BMIUnit.m,
                sliderV: provider.heightV,
                slideDiv: 150,
                slidermin: 1.1,
                slidermax: 2.2,
                onChange: (newValue) {
                  provider.changeH(newValue);
                },
              ),
            ),
            Consumer<BmiProvider>(
              builder: (context, provider, child) => BmiSlider(
                label: 'Weight',
                unit: BMIUnit.kg,
                sliderV: provider.weightV,
                slideDiv: 200,
                slidermin: 30,
                slidermax: 150,
                onChange: (newValue) {
                  provider.changeW(newValue);
                },
              ),
            ),
            Consumer<BmiProvider>(
              builder: (context, provider, child) => Expanded(
                child: BmiResult(
                    color: provider.color,
                    bmi: provider.bmi,
                    status: provider.status),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BmiSlider extends StatelessWidget {
  const BmiSlider({
    super.key,
    required this.label,
    required this.unit,
    required this.sliderV,
    required this.slideDiv,
    required this.slidermin,
    required this.slidermax,
    required this.onChange,
  });

  final String label;
  final BMIUnit unit;
  final double sliderV;
  final int slideDiv;
  final double slidermax, slidermin;
  final Function(double) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: txtlabestyle,
            ),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: RichText(
                  text: TextSpan(
                      text: sliderV.toStringAsFixed(1),
                      style: txtvaluestyle,
                      children: [
                    TextSpan(
                      text: ' ${unit.name}',
                      style: txtlabestyle.copyWith(fontSize: 20),
                    )
                  ])),
            )
          ],
        ),
        Slider(
          activeColor: Colors.white,
          inactiveColor: Colors.white,
          label: sliderV.toStringAsFixed(1),
          value: sliderV,
          divisions: slideDiv,
          max: slidermax,
          min: slidermin,
          onChanged: (value) {
            onChange(value);
          },
        )
      ],
    );
  }
}

class BmiResult extends StatelessWidget {
  final Color color;
  final double bmi;
  final String status;

  const BmiResult(
      {super.key,
      required this.color,
      required this.bmi,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(microseconds: 500),
          alignment: Alignment.center,
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 10)),
          child: Text(
            bmi.toStringAsFixed(1),
            style: txtvaluestyle.copyWith(fontSize: 50),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            status,
            style: const TextStyle(
              letterSpacing: 1.2,
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
