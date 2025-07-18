import 'package:bmi_calc/bmi_result_screen.dart';
import 'package:flutter/material.dart';

class BMIHome extends StatefulWidget {
  const BMIHome({super.key});

  @override
  _BMIHomeState createState() => _BMIHomeState();
}

class _BMIHomeState extends State<BMIHome> {
  final _formKey = GlobalKey<FormState>();
  double _height = 170;
  double _weight = 70;
  int _age = 25;
  String? _gender;
  String? _activityLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI Calculator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0f0c29), Color(0xFF302b63), Color(0xFF24243e)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 80.0, 16.0, 16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildCard(
                  child: _buildHeightSlider(),
                ),
                SizedBox(height: 20),
                _buildCard(
                  child: _buildWeightSlider(),
                ),
                SizedBox(height: 20),
                _buildCard(
                  child: _buildAgeField(),
                ),
                SizedBox(height: 20),
                _buildCard(
                  child: _buildGenderDropdown(),
                ),
                SizedBox(height: 20),
                _buildCard(
                  child: _buildActivityLevelDropdown(),
                ),
                SizedBox(height: 40),
                _buildCalculateButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: child,
    );
  }

  Widget _buildHeightSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Height',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.purpleAccent,
                  inactiveTrackColor: Colors.white.withOpacity(0.3),
                  thumbColor: Colors.amberAccent,
                  overlayColor: Colors.purpleAccent.withAlpha(0x29),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 14.0),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                ),
                child: Slider(
                  value: _height,
                  min: 100,
                  max: 250,
                  label: _height.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _height = value;
                    });
                  },
                ),
              ),
            ),
            Text('${_height.round()} cm',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildWeightSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Weight',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.purpleAccent,
                  inactiveTrackColor: Colors.white.withOpacity(0.3),
                  thumbColor: Colors.amberAccent,
                  overlayColor: Colors.purpleAccent.withAlpha(0x29),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 14.0),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                ),
                child: Slider(
                  value: _weight,
                  min: 30,
                  max: 200,
                  label: _weight.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _weight = value;
                    });
                  },
                ),
              ),
            ),
            Text('${_weight.round()} kg',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildAgeField() {
    return TextFormField(
      initialValue: _age.toString(),
      decoration: _inputDecoration('Age'),
      style: TextStyle(color: Colors.white, fontSize: 18),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your age';
        }
        if (int.tryParse(value) == null || int.parse(value) <= 0) {
          return 'Please enter a valid age';
        }
        return null;
      },
      onSaved: (value) {
        _age = int.parse(value!);
      },
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _gender,
      decoration: _inputDecoration('Gender'),
      dropdownColor: Color(0xFF302b63),
      icon: Icon(Icons.arrow_drop_down, color: Colors.purpleAccent),
      style: TextStyle(color: Colors.white, fontSize: 18),
      items: ['Male', 'Female']
          .map((label) => DropdownMenuItem(
                child: Text(label),
                value: label,
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _gender = value;
        });
      },
      validator: (value) => value == null ? 'Please select a gender' : null,
    );
  }

  Widget _buildActivityLevelDropdown() {
    return DropdownButtonFormField<String>(
      value: _activityLevel,
      decoration: _inputDecoration('Activity Level'),
      dropdownColor: Color(0xFF302b63),
      isExpanded: true,
      icon: Icon(Icons.arrow_drop_down, color: Colors.purpleAccent),
      style: TextStyle(color: Colors.white, fontSize: 18),
      items: [
        'Sedentary (little or no exercise)',
        'Lightly active (light exercise/sports 1-3 days/week)',
        'Moderately active (moderate exercise/sports 3-5 days/week)',
        'Very active (hard exercise/sports 6-7 days a week)',
        'Extra active (very hard exercise/sports & physical job)'
      ]
          .map((label) => DropdownMenuItem(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                ),
                value: label,
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _activityLevel = value;
        });
      },
      validator: (value) =>
          value == null ? 'Please select an activity level' : null,
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      filled: true,
      fillColor: Colors.black.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      errorStyle: TextStyle(color: Colors.amberAccent),
    );
  }

  Widget _buildCalculateButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purpleAccent,
        padding: EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadowColor: Colors.purpleAccent.withOpacity(0.5),
        elevation: 10,
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  BMIResultScreen(
                height: _height,
                weight: _weight,
                age: _age,
                gender: _gender!,
                activityLevel: _activityLevel!,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = Offset(0.0, 1.0);
                var end = Offset.zero;
                var curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        }
      },
      child: Text(
        'Calculate BMI',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    );
  }
}
