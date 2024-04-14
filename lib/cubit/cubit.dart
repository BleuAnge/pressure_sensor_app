// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(
    const HomeInitial(
      isSensorAvailable: "Haven't Checked Yet"
    )
  );

  static const methodChannel = 
    MethodChannel("com.example.pressureSensorApp/method");

  static const eventChannel = 
    EventChannel("com.example.pressureSensorApp/event");
  
  Future<void> isSensorAvailable() async { 
    try {
      bool availability = await methodChannel.invokeMethod("isSensorAvailable");
    
      emit(
        (state as HomeInitial).copyWith(
          isSensorAvailable: switch (availability) {
            true => "Available",
            false => "Not Available"
          }
        )
      );
    } on PlatformException catch (error) {
      debugPrint(error.message);
    }

  }

  Future<void> checkPressure() async {
    try {
      emit(
        HomeLoaded(
          streamSubscription: eventChannel.receiveBroadcastStream().listen((event) {
            emit(
              (state as HomeLoaded).copyWith(
                pressure: event
              )
            );
          }), 
          pressure: 0
        )
      );
    } on PlatformException catch (error) {
      debugPrint(error.message);
    }
  }

  void goBack() {
    (state as HomeLoaded).streamSubscription.cancel();
    emit(
      const HomeInitial(isSensorAvailable: "Haven't Checked Yet")
    );
  }
}
