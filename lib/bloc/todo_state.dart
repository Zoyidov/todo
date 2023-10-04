part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class NavigationInitial extends TodoState {}

class NavigationAddState extends TodoState{}

class NavigationDeleteState extends TodoState{}

class NavigationUpdateState extends TodoState{}

class NavigationSuccessState extends TodoState{}

class NavigationErrorState extends TodoState{
  final String text;

  NavigationErrorState({required this.text});
}

class NavigationLoadingState extends TodoState{}
