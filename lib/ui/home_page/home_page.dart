import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:udevs/bloc/todo_bloc.dart';
import 'package:udevs/ui/home_page/calendar_todo.dart';
import 'package:udevs/ui/routes/app_routes.dart';
import 'package:udevs/utils/colors.dart';
import 'package:udevs/utils/icons.dart';
import 'package:udevs/widgets/event.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../data/model/db_model.dart';
import '../detail/detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<TodoModel> events = [];
  DateTime selectedDate = DateTime.now();

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 40,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppIcons.notification),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          DateFormat('EEEE').format(selectedDate),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 11,
            child: CalendarWidget(
              onDateSelected: _onDateSelected,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Schedule",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                ZoomTapAnimation(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.addEvent);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 14.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22.0,
                        vertical: 10.0,
                      ),
                      child: SvgPicture.asset(
                        AppIcons.add,
                        height: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodoLoaded) {
                  final filteredEvents = state.todos.where((event) {
                    final eventDate = event.dateCreated;
                    return eventDate.year == selectedDate.year &&
                        eventDate.month == selectedDate.month &&
                        eventDate.day == selectedDate.day;
                  }).toList();
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) {
                      final event = filteredEvents[index];
                      Color eventColor =
                      Color(int.parse(event.priorityColor, radix: 16));
                      return ZoomTapAnimation(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EventDetailScreen(todo: event),
                            ),
                          );
                        },
                        child: Event(
                          color: eventColor,
                          name: event.name,
                          description: event.description,
                          location: event.location,
                          time: event.time,
                          tColor: event.priorityColor == "ff009fee"
                              ? AppColors.c_056
                              : event.priorityColor == "ffee2b00"
                              ? AppColors.red
                              : event.priorityColor == "ffee8f00"
                              ? AppColors.orange
                              : AppColors.black,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 14);
                    },
                  );
                } else if (state is TodoLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TodoError) {
                  return Center(
                    child: Text('Error: ${state.errorMessage}'),
                  );
                }
                return Center(
                  child: Text('Unknown state: ${state.toString()}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
