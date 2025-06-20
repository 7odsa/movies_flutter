import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movies_flutter/feat/home/presentation/screens/home_screen.dart';

part 'nav_screen_state.dart';

class NavScreenCubit extends Cubit<Widget> {
  NavScreenCubit() : super(HomeScreen());

  void changeScreen(Widget newScreen) {
    emit(newScreen);
  }
}
