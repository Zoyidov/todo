import 'package:flutter/material.dart';
import 'package:udevs/ui/home_page/widget/calendar_button.dart';
import '../../data/local/db.dart';
import '../../utils/colors.dart';

class CalendarWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const CalendarWidget({super.key, required this.onDateSelected});

  @override
  // ignore: library_private_types_in_public_api
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

  final List<String> daysNames = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentMonth - 1,
    );
    fetchSavedDays();
    selectedDate = DateTime.now();
  }

  bool isDateSaved(int month, int day) {
    if (savedDays.containsKey(month)) {
      return savedDays[month]!.contains(day);
    }
    return false;
  }

  int getSavedDataCount(DateTime date) {
    final month = date.month;
    final day = date.day;
    if (savedDays.containsKey(month)) {
      return savedDays[month]!.where((savedDay) => savedDay == day).length;
    }
    return 0;
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



  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 10,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${selectedDate.day}  ${monthNames[selectedDate.month - 1]}',
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  '${selectedDate.year}',
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        monthNames[monthIndex],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color:  AppColors.black
                        ),
                      ),
                    ),
                    CalendarButton(
                      nextAction: () {
                        _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                      },
                      beforeAction: () {
                        _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    for (var dayName in daysNames)
                      Expanded(
                        child: Center(
                          child: Text(
                            dayName,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: dayName == 'Sat' || dayName == 'Sun'
                                  ? AppColors.red
                                  : AppColors.black,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: daysInMonth,
                  itemBuilder: (context,dayIndex) {
                    int day = dayIndex + 1;
                    Color textColor = AppColors.black;
                    bool isToday = DateTime.now().year == selectedYear &&
                        DateTime.now().month == month &&
                        DateTime.now().day == day;

                    if (daysNames[(dayIndex + 6) % 7] == 'Sat' ||
                        daysNames[(dayIndex + 1) % 7] == 'Sun') {
                      textColor = AppColors.red;
                    }
                    if (isToday) {
                      textColor = Colors.deepPurpleAccent;
                    }
                    bool isSaved = isDateSaved(month, day);
                    int savedDataCount = getSavedDataCount(DateTime(selectedYear, month, day));
                    List<Color> dotColors = [];
                    if (isSaved) {
                      for (int i = 0; i < savedDataCount; i++) {
                        dotColors.add(
                          _getDotColorBasedOnData(i),
                        );
                      }
                    }

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDay = day;
                          selectedDay = day;
                          selectedDate = DateTime(selectedYear, month, day);
                        });
                        widget.onDateSelected(selectedDate);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedDay == day
                                  ? Colors.blue
                                  : Colors.transparent,
                              border: Border.all(
                                color: selectedDay == day
                                    ? Colors.blue
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isToday? AppColors.black: Colors.transparent,
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
                          ),
                          const SizedBox(height: 3),
                          if (isSaved)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: dotColors
                                  .map((color) => DotWidget(color))
                                  .toList(),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DotWidget extends StatelessWidget {
  final Color color;

  const DotWidget(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

Color _getDotColorBasedOnData(int index) {
  List<Color> predefinedColors = [
    AppColors.blue,
    AppColors.red,
    AppColors.orange,
  ];
  return predefinedColors[index % predefinedColors.length];
}
