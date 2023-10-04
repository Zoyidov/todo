part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class AddEventState extends TodoEvent {
  final EventModel eventModel;

  AddEventState({required this.eventModel});
}


class DeleteEventState extends TodoEvent {
  final int id;

  DeleteEventState({required this.id});
}
