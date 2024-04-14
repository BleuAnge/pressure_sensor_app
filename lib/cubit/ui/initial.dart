import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressure_sensor_app/cubit/cubit.dart';

class InitialPage extends StatelessWidget {
  final String isSensorAvailable;

  const InitialPage({
    required this.isSensorAvailable,
    super.key
  });

  @override
  Widget build(BuildContext context) =>
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,

        children: [
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "Is Barometer Available: ",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: isSensorAvailable,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          MaterialButton(
            onPressed: () {
              context.read<HomeCubit>().isSensorAvailable();
            },
            color: Colors.blueAccent,
            textColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            child: const Text("Check Barometer Availability"),
          ),
          const SizedBox(
            height: 8,
          ),
          switch (isSensorAvailable) {
            "Available" => MaterialButton(
              onPressed: () {
                context.read<HomeCubit>().checkPressure();
              },
              color: Colors.blueAccent,
              textColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              child: const Text("Check Pressure"),
            ),
            _ => const SizedBox.shrink()
          }
          // MaterialButton(
          //   onPressed: () {
          //     context.read<HomeCubit>().fetchVariable();
          //   },
          //   color: Colors.blueAccent,
          //   textColor: Colors.white,
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 32,
          //     vertical: 16,
          //   ),
          //   child: const Text("Fetch Variable"),
          // ),
        ],
      )
    );
}