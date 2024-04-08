import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/list_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 24, 30, 41),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Lottie.asset('assets/Animation - 1701451576906.json'),
              const SizedBox(
                height: 300,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListScreen(),
                        ));
                  },
                  child: const Text(
                    'Explore',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ));
  }
}
