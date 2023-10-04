
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:udevs/data/local/db.dart';
import 'package:udevs/data/model/db_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(NavigationInitial()) {
    on<AddEventState>(_addEvent);
    on<DeleteEventState>(_deleteEvent);
  }
  _addEvent(AddEventState event, Emitter<TodoState> emit)async{
    try{
      LocalDatabase.insert(event.eventModel);
      emit(NavigationAddState());
    }
        catch(e){
      debugPrint(e.toString());
        }
        emit(NavigationInitial());
  }
  _deleteEvent(DeleteEventState event, Emitter<TodoState> emit)async{
    emit (NavigationLoadingState());
    try{
      LocalDatabase.delete(event.id);
      emit(NavigationAddState());
    }
        catch(e){
      emit(NavigationErrorState(text: '$e'));
        }
        emit(NavigationInitial());
  }
}
