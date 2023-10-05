import 'package:flutter/cupertino.dart';
import '../../../data/model/db_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/icons.dart';
import 'appbar_details.dart';

Widget buildAppBarContent(TodoModel event, Color eventColor) {
  bool showLocationIcon = event.location.isNotEmpty;

  return Container(
    height: 204,
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
          Text(
            event.name.length <= 20
                ? event.name
                : '${event.name.substring(0, 20)}...',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 10),
            buildInfoRow( AppIcons.clock, event.time,),
          const SizedBox(height: 10),
          if (showLocationIcon)
            buildInfoRow(AppIcons.location, event.location),
        ],
      ),
    ),
  );
}
