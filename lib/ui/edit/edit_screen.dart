import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udevs/bloc/todo_bloc.dart';
import 'package:udevs/data/model/db_model.dart';
import 'package:udevs/utils/colors.dart';
import 'package:udevs/widgets/textfield.dart';
import '../routes/app_routes.dart';

class EditEventScreen extends StatefulWidget {
  final TodoModel todo;

  const EditEventScreen({Key? key, required this.todo}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDescriptionController =
      TextEditingController();
  final TextEditingController eventLocationController = TextEditingController();
  final TextEditingController eventTimeController = TextEditingController();
  final TextEditingController eventColorController = TextEditingController();

  @override
  void initState() {
    super.initState();

    eventNameController.text = widget.todo.name;
    eventDescriptionController.text = widget.todo.description;
    eventLocationController.text = widget.todo.location;
    eventTimeController.text = widget.todo.time;
    eventColorController.text = widget.todo.priorityColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Edit Event"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalTextField(
                hintText: "",
                keyboardType: TextInputType.text,
                caption: "Event Name",
                textInputAction: TextInputAction.next,
                controller: eventNameController,
              ),
              const SizedBox(height: 20),
              GlobalTextField(
                hintText: "",
                keyboardType: TextInputType.text,
                caption: "Event Description",
                textInputAction: TextInputAction.next,
                controller: eventDescriptionController,
              ),
              const SizedBox(height: 20),
              GlobalTextField(
                hintText: "",
                keyboardType: TextInputType.text,
                caption: "Event Location",
                textInputAction: TextInputAction.next,
                controller: eventLocationController,
              ),
              const SizedBox(height: 20),
              GlobalTextField(
                hintText: "",
                keyboardType: TextInputType.number,
                caption: "Event Time",
                textInputAction: TextInputAction.done,
                controller: eventTimeController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String updatedName = eventNameController.text;
                  String updatedDescription = eventDescriptionController.text;
                  String updatedLocation = eventLocationController.text;
                  String updatedTime = eventTimeController.text;
                  String updatedColor = eventColorController.text;

                  TodoModel updatedTodo = TodoModel(
                    id: widget.todo.id,
                    name: updatedName,
                    description: updatedDescription,
                    location: updatedLocation,
                    time: updatedTime,
                    priorityColor: updatedColor, dateCreated: DateTime.now(),
                  );

                  context.read<TodoBloc>().add(UpdateTodo(updatedTodo));

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteNames.homePage,
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color(int.parse('0xFF${eventColorController.text}')),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    "Update",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
