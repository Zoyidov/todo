import 'package:flutter/cupertino.dart';

import '../../../data/model/db_model.dart';
import '../../../utils/colors.dart';
import 'detail_text.dart';

Container buildEventDetails(TodoModel event) {
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
          buildEventDetailText("Reminder", event.time, AppColors.black,),
          const SizedBox(height: 16.0),
          buildEventDetailText("Description", event.description, AppColors.black,),
        ],
      ),
    ),
  );
}