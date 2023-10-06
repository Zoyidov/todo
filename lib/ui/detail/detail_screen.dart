import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:udevs/bloc/todo_bloc.dart';
import 'package:udevs/ui/detail/widgets/body_details.dart';
import 'package:udevs/ui/detail/widgets/delete_button.dart';
import 'package:udevs/ui/detail/widgets/appbar.dart';
import 'package:udevs/utils/colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../data/model/db_model.dart';
import '../../utils/icons.dart';
import '../edit/edit_screen.dart';

class EventDetailScreen extends StatelessWidget {
  final TodoModel todo;

  const EventDetailScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final Color eventColor = Color(int.parse(todo.priorityColor, radix: 16));

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: eventColor,
        leadingWidth: 75,
        leading: ZoomTapAnimation(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.white,
            ),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditEventScreen(todo: todo),
                  ),
                );
              },
              icon: Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.edit,
                    width: 20,
                  ),
                  const Text(
                    "Edit",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAppBarContent(todo, eventColor),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: buildEventDetails(todo),
            ),
          ),

          buildDeleteButton(
                () {
              if (todo.id != null) {
                Navigator.of(context).pop();
                context.read<TodoBloc>().add(DeleteTodo(todo.id!));
              }
            },
          )
        ],
      ),
    );
  }
}
