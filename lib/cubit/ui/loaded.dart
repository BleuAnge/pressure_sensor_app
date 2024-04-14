import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressure_sensor_app/cubit/cubit.dart';

class LoadedPage extends StatelessWidget {
  final double pressure;
  const LoadedPage({
    required this.pressure,
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
                  text: "Current Pressure: ",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: "$pressure",
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
              context.read<HomeCubit>().goBack();
            },
            color: Colors.blueAccent,
            textColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            child: const Text("Go Back"),
          ),
          const SizedBox(
            height: 8,
          ),
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