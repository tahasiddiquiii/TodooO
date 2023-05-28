import 'package:flutter/material.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';

class WavyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double waveHeight;

  const WavyAppBar({super.key, this.waveHeight = 0.0001});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform(
          transform: Matrix4.rotationX(3.14159265),
          alignment: Alignment.center,
          child: WaveWidget(
            config: CustomConfig(
              gradients: [
                [
                  const Color.fromARGB(255, 29, 57, 69),
                  Colors.cyan,
                ],
              ],
              durations: [20000],
              heightPercentages: [waveHeight],
              blur: const MaskFilter.blur(BlurStyle.solid, 10),
            ),
            size: const Size(double.infinity, double.infinity),
            waveAmplitude: 0,
          ),
        ),
        AppBar(
          title: const Center(
            child: Text.rich(
              TextSpan(
                text: 'Tod',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white,
                  fontFamily: "Pacifico",
                ),
                children: [
                  TextSpan(
                    text: 'o',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: "Pacifico",
                    ),
                  ),
                  TextSpan(
                    text: 'oO',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white,
                      fontFamily: "Pacifico",
                    ),
                  ),
                ],
              ),
            ),
          ),
          elevation: 10,
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }
}
