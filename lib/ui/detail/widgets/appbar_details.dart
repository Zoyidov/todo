import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/colors.dart';


Widget buildInfoRow(String iconPath, String text) {
  return Row(
    children: [
      SvgPicture.asset(
        iconPath,
        // ignore: deprecated_member_use
        color: AppColors.white,
      ),
      const SizedBox(width: 5,),
      Expanded(
        child: Text(
          text,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 10,
            color: AppColors.white,
          ),
        ),
      ),
    ],
  );
}
