import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:udevs/bloc/todo_bloc.dart';
import 'package:udevs/rote/app_routes.dart';
import 'package:udevs/utils/colors.dart';
import 'package:udevs/utils/icons.dart';
import 'package:udevs/widgets/event.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../data/local/db.dart';
import '../../data/model/db_model.dart';
import '../detail/detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<EventModel> events = [];
  _init()async{
    events = await LocalDatabase.getAll();
  }

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    LocalDatabase.getInstance;
    _init();
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(onPressed: () {},
                icon: SvgPicture.asset(AppIcons.notification),)
          ),
        ],
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          DateFormat('EEEE').format(DateTime.now()),
          style: const TextStyle(color: Colors.black),
        )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: BlocConsumer<TodoBloc, TodoState>(
            listener: (context, state) {
                if(state is NavigationAddState){
                  print("error: $state}");
                  _init();
                  setState(() {
                  });
                }
                if( state is NavigationErrorState){
                  print("error: ${state.text}");
                }
            },
            builder: (context, state) {
              return Column(
                children: [
              CalendarDatePicker(
                initialDate: selectedDate,
                firstDate: DateTime(2023, 1, 1),
                lastDate: DateTime(2023, 12, 31),
                onDateChanged: (newDate) {

                  setState(() {
                    selectedDate = newDate;
                  });
                },
              ),
              Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Schedule",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      ZoomTapAnimation(
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.addEvent);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 28.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.blue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 10.0),
                            child: SvgPicture.asset(AppIcons.add, height: 12,),
                          ),
                        ),
                      )
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      Color eventColor =
                      Color(int.parse(event.priorityColor, radix: 16));

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 28.0),
                        child: ZoomTapAnimation(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EventDetailScreen(event: event),
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
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30.0),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
