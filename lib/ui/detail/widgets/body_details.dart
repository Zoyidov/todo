import 'package:flutter/material.dart';
import 'package:udevs/data/model/db_model.dart';
import 'package:udevs/utils/colors.dart';

import 'detail_text.dart';

int calculateTimeDifferenceInMinutes(DateTime savedTime) {
  DateTime currentTime = DateTime.now();
  Duration difference = savedTime.difference(currentTime);
  return difference.inMinutes;
}

Container buildEventDetails(TodoModel event) {
  DateTime savedTime = DateTime.parse(event.dateCreated.toString());

  int timeDifferenceInMinutes = calculateTimeDifferenceInMinutes(savedTime);

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 16.0),
          buildEventDetailText(
            "Reminder",
            '${timeDifferenceInMinutes * (-1)} minutes before',
            AppColors.black,
          ),
          const SizedBox(height: 16.0),
          buildEventDetailText(
            "Description",
            event.description,
            AppColors.black,
          ),
        ],
      ),
    ),
  );
}

String formatTimeDifference(Duration duration) {
  int hours = duration.inHours;
  int minutes = duration.inMinutes % 60;
  return '${hours}h ${minutes}m';
}
