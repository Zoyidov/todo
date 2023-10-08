import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CalendarButton extends StatelessWidget {
  final VoidCallback nextAction;
  final VoidCallback beforeAction;

  const CalendarButton({
    Key? key,
    required this.nextAction,
    required this.beforeAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Row(
        children: [
          ZoomTapAnimation(
            onTap: beforeAction,
            child: _buildButton(Icons.navigate_before),
          ),
          const SizedBox(width: 10),
          ZoomTapAnimation(
            onTap: nextAction,
            child: _buildButton(Icons.navigate_next),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black12,
      ),
      child: Icon(iconData),
    );
  }
}
