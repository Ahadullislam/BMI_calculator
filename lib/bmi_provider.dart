import 'package:flutter/material.dart';

import 'constant.dart';

class BmiProvider extends ChangeNotifier {
  double _heightV = 1.5;
  double _weightV = 50;
  String _status = '';
  double _bmi = 0.0;
  Color _color = Colors.green;

  double get heightV => _heightV;
  double get weightV => _weightV;
  String get status => _status;
  double get bmi => _bmi;
  Color get color => _color;

  BmiProvider() {
    _updateBmi();
  }

  changeH(double value) {
    _heightV = value;
    _updateBmi();
    notifyListeners();
  }

  changeW(double value) {
    _weightV = value;
    _updateBmi();
    _updateColor();
    notifyListeners();
  }

  _updateBmi() {
    _bmi = weightV / (heightV * heightV);
    _updateStatus();
    _updateColor();
  }

  _updateStatus() {
    _status = _getStatus();
  }

  _getStatus() {
    if (bmi < 16.0) {
      return BMI.uwsevere;
    }
    if (bmi >= 16.0 && bmi <= 16.9) {
      return BMI.uwmoderate;
    }
    if (bmi >= 17.0 && bmi <= 18.4) {
      return BMI.uwmild;
    }
    if (bmi >= 18.5 && bmi <= 24.9) {
      return BMI.normal;
    }
    if (bmi >= 25.0 && bmi <= 29.9) {
      return BMI.owpre;
    }
    if (bmi >= 30.0 && bmi <= 34.9) {
      return BMI.obese_1;
    }
    if (bmi >= 35.5 && 39.9 >= bmi) {
      return BMI.obese_2;
    }
    return BMI.obese_3;
  }

  _updateColor() {
    if (bmi < 16.0) {
      _color = Colors.green.shade200;
    } else if (bmi >= 16.0 && bmi <= 16.9) {
      _color = Colors.green.shade300;
    } else if (bmi >= 17.0 && bmi <= 18.4) {
      _color = Colors.green.shade400;
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      _color = Colors.green;
    } else if (bmi >= 25.0 && bmi <= 29.9) {
      _color = Colors.red.shade200;
    } else if (bmi >= 30.0 && bmi <= 34.9) {
      _color = Colors.red.shade300;
    } else if (bmi >= 35.5 && 39.9 >= bmi) {
      _color = Colors.red.shade400;
    } else
      _color = Colors.red;
  }
}
