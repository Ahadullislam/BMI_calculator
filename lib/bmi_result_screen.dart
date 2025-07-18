import 'package:flutter/material.dart';
import 'dart:math';

class BMIResultScreen extends StatefulWidget {
  final double height;
  final double weight;
  final int age;
  final String gender;
  final String activityLevel;

  BMIResultScreen({
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
    required this.activityLevel,
  });

  @override
  _BMIResultScreenState createState() => _BMIResultScreenState();
}

class _BMIResultScreenState extends State<BMIResultScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double _bmi;

  @override
  void initState() {
    super.initState();
    _bmi = widget.weight / ((widget.height / 100) * (widget.height / 100));
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: _bmi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String category = '';
    Color categoryColor = Colors.white;
    String advice = '';
    String foodSuggestions = '';
    String idealWeight =
        '${(18.5 * pow(widget.height / 100, 2)).toStringAsFixed(1)} - ${(24.9 * pow(widget.height / 100, 2)).toStringAsFixed(1)} kg';

    if (_bmi < 18.5) {
      category = 'Underweight';
      categoryColor = Colors.blue;
      advice =
          'Focus on nutrient-dense foods to build healthy muscle and fat stores. Incorporate strength training to build lean mass.';
      foodSuggestions =
          'Breakfast: Oatmeal with nuts and seeds.\nLunch: Grilled chicken or tofu with quinoa and roasted vegetables.\nDinner: Salmon with sweet potato and avocado.';
    } else if (_bmi >= 18.5 && _bmi <= 24.9) {
      category = 'Normal';
      categoryColor = Colors.green;
      advice = 'Excellent! Maintain your healthy weight with a balanced diet and regular physical activity.';
      foodSuggestions =
          'Breakfast: Greek yogurt with berries.\nLunch: Large salad with a variety of veggies and a lean protein source.\nDinner: Baked fish with steamed broccoli and brown rice.';
    } else if (_bmi >= 25 && _bmi <= 29.9) {
      category = 'Overweight';
      categoryColor = Colors.orange;
      advice =
          'A slight calorie deficit combined with regular cardio and strength training can help you reach a healthier weight.';
      foodSuggestions =
          'Breakfast: Scrambled eggs with spinach.\nLunch: Turkey and avocado wrap on whole wheat.\nDinner: Lean beef stir-fry with plenty of vegetables.';
    } else {
      category = 'Obese';
      categoryColor = Colors.red;
      advice =
          'It is recommended to consult with a healthcare provider or a registered dietitian to create a safe and effective weight loss plan.';
      foodSuggestions =
          'Focus on whole, unprocessed foods. Limit sugary drinks, processed snacks, and large portion sizes. A structured meal plan from a professional is highly recommended.';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Result'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0f0c29), Color(0xFF302b63), Color(0xFF24243e)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: BMICirclePainter(_animation.value, categoryColor),
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _animation.value.toStringAsFixed(1),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'BMI',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 30),
                _buildCategoryCard(category, categoryColor),
                SizedBox(height: 30),
                _buildInfoCard('Ideal Weight', idealWeight),
                SizedBox(height: 20),
                _buildInfoCard('Personalized Advice', advice),
                SizedBox(height: 20),
                _buildInfoCard('Meal Suggestions', foodSuggestions),
                SizedBox(height: 30),
                Text(
                  '"The greatest wealth is health."',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                      fontStyle: FontStyle.italic),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String category, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Text(
        category,
        style: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Text(
            content,
            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class BMICirclePainter extends CustomPainter {
  final double bmi;
  final Color color;

  BMICirclePainter(this.bmi, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke;

    Paint progressPaint = Paint()
      ..color = color
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, backgroundPaint);

    double progressAngle = 2 * pi * (bmi / 40); // Assuming max BMI of 40 for the progress arc

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
