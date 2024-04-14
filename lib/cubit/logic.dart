import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressure_sensor_app/cubit/cubit.dart';
import 'package:pressure_sensor_app/cubit/ui/initial.dart';
import 'package:pressure_sensor_app/cubit/ui/loaded.dart';
import 'package:pressure_sensor_app/cubit/ui/loading.dart';

class HomeLogic extends StatefulWidget {
  const HomeLogic({super.key});

  @override
  State<HomeLogic> createState() => _HomeLogicState();
}

class _HomeLogicState extends State<HomeLogic> {

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
    builder: (context, state) {
      return Scaffold(
        body: switch (state) {
          HomeInitial() => InitialPage(
            isSensorAvailable: state.isSensorAvailable,
          ),

          HomeLoading() => const LoadingPage(),

          HomeLoaded() => LoadedPage(
            pressure: state.pressure,
          ),
        },
      );
    }
  );
}