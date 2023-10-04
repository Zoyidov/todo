import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:udevs/bloc/todo_bloc.dart';
import 'package:udevs/data/local/db.dart';
import 'package:udevs/ui/detail/widgets/body_details.dart';
import 'package:udevs/ui/detail/widgets/delete_button.dart';
import 'package:udevs/ui/detail/widgets/detail_appbar.dart';
import 'package:udevs/utils/colors.dart';
import '../../data/model/db_model.dart';
import '../../utils/icons.dart';

class EventDetailScreen extends StatelessWidget {
  final EventModel event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final Color eventColor = Color(int.parse(event.priorityColor, radix: 16));

    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(event, eventColor),
          buildEventDetails(event),
        ],
      ),
      bottomNavigationBar: buildDeleteButton(() {
        if (event.id != null) {
          Navigator.of(context).pop();
          LocalDatabase.delete(event.id!);
          context.read<TodoBloc>().add(DeleteEventState(id: event.id!));
      }
      }),
    );
  }

  SliverAppBar _buildAppBar(EventModel event, Color eventColor) {
    return SliverAppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      expandedHeight: 250.0,
      pinned: true,
      leading: _buildBackButton(),
      actions: [
        _buildEditButton(),
      ],
      leadingWidth: 75,
      flexibleSpace: FlexibleSpaceBar(
        background: buildAppBarContent(event, eventColor),
      ),
    );
  }

  Widget _buildBackButton() {
    return Container(
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.white,
      ),
      child: const Icon(Icons.arrow_back_ios),
    );
  }

  Widget _buildEditButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: IconButton(
        onPressed: () {},
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
    );
  }
}
