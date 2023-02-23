import 'package:bloc_lesson/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<MainState> {
  CounterCubit() : super(MainState());

  void increment() {
    emit(state.copyWith(c: state.counter + 1));
  }

  void decrement() {
    emit(state.copyWith(c: state.counter - 1));
  }

  void addName(String name) {
    emit(state.copyWith(n: name));
  }
}