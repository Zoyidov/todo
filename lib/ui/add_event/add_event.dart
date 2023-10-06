import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udevs/bloc/todo_bloc.dart';
import 'package:udevs/utils/colors.dart';
import 'package:udevs/widgets/textfield.dart';
import '../../data/local/db.dart';
import '../../data/model/db_model.dart';
import '../../utils/icons.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final LocalDatabase databaseHelper = LocalDatabase.getInstance;
  Color? _selectedColor = AppColors.blue;

  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDescriptionController =
  TextEditingController();
  final TextEditingController eventLocationController = TextEditingController();
  final TextEditingController eventTimeController = TextEditingController();

  final bool _isSaving = false;
  bool _eventNameValid = false;
  bool _eventTimeValid = false;

  @override
  void initState() {
    super.initState();
  }

  void _showColorPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildColorOption('Blue color', AppColors.blue),
            _buildColorOption('Red color', AppColors.red),
            _buildColorOption('Orange color', AppColors.orange),
            _buildColorOption('', AppColors.white),
          ],
        );
      },
    );
  }

  Widget _buildColorOption(String colorName, Color color) {
    return ListTile(
      leading: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
      title: Text(colorName),
      onTap: () {
        setState(() {
          _selectedColor = color;
        });
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalTextField(
                controller: eventNameController,
                hintText: '',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                caption: 'Event name',
                onChanged: (text) {
                  setState(() {
                    _eventNameValid = text.isNotEmpty;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              GlobalTextField(
                controller: eventDescriptionController,
                max: 5,
                hintText: '',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                caption: 'Event description',
              ),
              const SizedBox(
                height: 16,
              ),
              GlobalTextField(
                controller: eventLocationController,
                hintText: '',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                caption: 'Event location',
                suffixIcon: AppIcons.location,
                color: AppColors.blue,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text("Priority color"),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  _showColorPicker(context);
                },
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: _selectedColor ?? AppColors.red,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GlobalTextField(
                controller: eventTimeController,
                hintText: '',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                caption: 'Event time',
                onChanged: (text) {
                  setState(() {
                    _eventTimeValid = text.isNotEmpty;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_isSaving) {
                    return;
                  } else if (_selectedColor == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select a color."),
                      ),
                    );
                  } else if (!_eventNameValid || !_eventTimeValid) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 500),
                        backgroundColor: AppColors.red,
                        content: Text("Event name and time are required."),
                      ),
                    );
                  } else {
                    Navigator.of(context).pop();
                    context.read<TodoBloc>().add(AddTodo(TodoModel(
                      name: eventNameController.text,
                      description: eventDescriptionController.text,
                      location: eventLocationController.text,
                      time: eventTimeController.text,
                      priorityColor:
                      _selectedColor?.value.toRadixString(16) ??
                          "FFFFFF", dateCreated: DateTime.now(),
                      // dateCreated: DateTime.now(),
                    )));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
