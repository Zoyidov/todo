import 'package:flutter/cupertino.dart';

import '../../../data/model/db_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/icons.dart';
import 'appbar_details.dart';

Widget buildAppBarContent(EventModel event, Color eventColor) {
  bool showLocationIcon = event.location.isNotEmpty;

  return Container(
    decoration: BoxDecoration(
      color: eventColor,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 100),
          Text(
            event.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 10),
          buildInfoRow(AppIcons.clock, event.time),
          const SizedBox(height: 10),
          if (showLocationIcon)
            buildInfoRow(AppIcons.location, event.location),
        ],
      ),
    ),
  );
}
