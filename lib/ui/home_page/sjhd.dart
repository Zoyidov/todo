import 'package:flutter/material.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, // 7 days in a week
      ),
      itemCount: 31, // Display days for a month
      itemBuilder: (context, index) {
        // Calculate the day of the month (1 to 31)
        int day = index + 1;

        // Customize styling for weekends (e.g., Saturday and Sunday)
        TextStyle textStyle = TextStyle();
        if (index % 7 == 5 || index % 7 == 6) {
          textStyle = TextStyle(
            color: Colors.red,
          );
        }

        return Center(
          child: Text(
            '$day',
            style: textStyle,
          ),
        );
      },
    );
  }
}
