import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/colors.dart';
import '../../../utils/icons.dart';

Widget buildDeleteButton(VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 50),
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.c_f6c,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppIcons.delete),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "Delete Event",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
