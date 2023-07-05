import 'package:flutter/material.dart';

import '../global.dart';

class CustomStepper extends StatefulWidget {
  final int currentStep;

  const CustomStepper({required this.currentStep});

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight, // Set the height according to your requirements
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildStep(0),
          _buildDivider(0),
          _buildStep(1),
          _buildDivider(1),
          _buildStep(2),
          if (lcc) _buildDivider(2),
          if (lcc) _buildStep(3),
        ],
      ),
    );
  }

  Widget _buildStep(int step) {
    final isSelected = widget.currentStep == step;
    final isCompleted = widget.currentStep > step;
    final selectedColor = Colors.yellow;
    final unselectedColor = Colors.grey;
    final completedColor = Colors.green;
    final dotColor = Colors.white;
    final dotSize = 5.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 12, // Set the width of each step point
          height: 12, // Set the height of each step point
          decoration: BoxDecoration(
            color: isSelected
                ? selectedColor
                : (isCompleted ? completedColor : unselectedColor),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Visibility(
              visible: isSelected || !isCompleted,
              child: Container(
                width: dotSize,
                height: dotSize,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(int step) {
    final unselectedColor = Colors.grey;

    if (step < widget.currentStep) {
      return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Container(
          width: 30, // Set the width of each divider
          height: 2, // Set the height of each divider
          color: Colors.white, // Set the color of the divider
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Container(
          width: 30, // Set the width of each divider
          height: 3, // Set the height of each divider
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                width: 7.5,
                decoration: BoxDecoration(
                  color: unselectedColor,
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
