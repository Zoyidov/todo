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
  Color? _selectedColor = AppColors.red;

  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDescriptionController =
  TextEditingController();
  final TextEditingController eventLocationController = TextEditingController();
  final TextEditingController eventTimeController = TextEditingController();

  bool _isSaving = false;

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

  Future<void> _saveEventToDatabase() async {
    setState(() {
      _isSaving = true;
    });

    final event = EventModel(
      name: eventNameController.text,
      description: eventDescriptionController.text,
      location: eventLocationController.text,
      time: eventTimeController.text,
      priorityColor: _selectedColor?.value.toRadixString(16) ?? "FFFFFF",
    );

    try {
      await LocalDatabase.insert(event);
      setState(() {
        _isSaving = false;
      });
    } catch (error) {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
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
              ),
              const SizedBox(
                height: 16,
              ),
              GlobalTextField(
                controller: eventDescriptionController,
                max: 10,
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
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                caption: 'Event time',
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
                  } else {
                    Navigator.of(context).pop();
                    context.read<TodoBloc>().add(AddEventState(eventModel: EventModel(name: eventNameController.text, description: eventDescriptionController.text, location: eventLocationController.text, time: eventTimeController.text, priorityColor: _selectedColor?.value.toRadixString(16) ?? "FFFFFF",
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 10),
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
