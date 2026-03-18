import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Helper/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ThemeBloc extends Bloc<AppEvent, ThemeState> {

  ThemeBloc() : super(ThemeState(themeMode: ThemeMode.light)) {

    on<ToggleThemeEvent>((event, emit) {

      if (state.themeMode == ThemeMode.light) {
        emit(ThemeState(themeMode: ThemeMode.dark));
      } else {
        emit(ThemeState(themeMode: ThemeMode.light));
      }

    });

  }

}