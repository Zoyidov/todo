import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../data/local/db.dart';
import '../../utils/colors.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  int selectedYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;
  int selectedDay = -1;
  int selectedMonth = DateTime.now().month;
  late PageController _pageController;
  Map<int, List<int>> savedDays = {};

  final List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentMonth - 1,
    );
    fetchSavedDays();
  }
  bool isDateSaved(int month, int day) {
    if (savedDays.containsKey(month)) {
      return savedDays[month]!.contains(day);
    }
    return false;
  }


  void fetchSavedDays() async {
    final savedDates = await LocalDatabase().getAllSavedDates();
    for (var date in savedDates) {
      final month = date.month;
      final day = date.day;
      if (!savedDays.containsKey(month)) {
        savedDays[month] = [day];
      } else {
        savedDays[month]!.add(day);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 10,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${DateTime.now().day}  ${monthNames[currentMonth - 1]} ',
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            Text(
              '$selectedYear',
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        itemBuilder: (context, monthIndex) {
          int month = monthIndex + 1;
          int daysInMonth = DateTime(selectedYear, month + 1, 0).day;
          bool isSelectedMonth = month == selectedMonth;
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ZoomTapAnimation(
                  onTap: () {
                    setState(() {
                      selectedMonth = month;
                    });
                  },
                  child: Text(
                    monthNames[monthIndex],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color:
                          isSelectedMonth ? AppColors.black : AppColors.c_f6c,
                    ),
                  ),
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: daysInMonth,
                  itemBuilder: (context, dayIndex) {
                    int day = dayIndex + 1;
                    Color textColor =
                        isSelectedMonth ? AppColors.black : Colors.grey;
                    if (day == DateTime.now().day &&
                        month == currentMonth &&
                        isSelectedMonth) {
                      textColor = AppColors.orange;
                    }
                    if (dayIndex % 7 == 5 || dayIndex % 7 == 6) {
                      textColor = AppColors.red;
                    }
                    bool isSaved = isDateSaved(month, day);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDay = day;
                        });
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedDay == day && isSelectedMonth
                                  ? Colors.blue
                                  : Colors.transparent,
                              border: Border.all(
                                color: selectedDay == day && isSelectedMonth
                                    ? Colors.blue
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              '$day',
                              style: TextStyle(
                                color: textColor,
                              ),
                            ),
                          ),
                          if (isSaved)
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.blue,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
