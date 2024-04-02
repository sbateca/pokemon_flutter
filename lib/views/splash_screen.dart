import 'package:flutter/material.dart';
import 'package:poke_app/views/views.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PokemonGridView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/splash_screen/splash.png'),
          const Text(
            'Loading',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: SleekCircularSlider(
              appearance: CircularSliderAppearance(
                spinnerMode: true,
                size: 50,
                customWidths:CustomSliderWidths(
                  progressBarWidth: 3,
                ),
                customColors: CustomSliderColors(
                  progressBarColors: [
                    const Color.fromARGB(255, 231, 231, 231),
                    const Color.fromARGB(255, 184, 184, 184),
                    const Color.fromARGB(255, 126, 126, 126)],
                    trackColor: const Color.fromARGB(255, 236, 236, 236)
                ),

            )),
          )
        ],
      ),
    );
  }
}
