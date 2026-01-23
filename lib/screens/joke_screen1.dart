// lib/screens/joke_screen1.dart
import 'package:flutter/material.dart';

class JokeScreen1 extends StatelessWidget {
  final VoidCallback onArrowTap;

  const JokeScreen1({super.key, required this.onArrowTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF8B0000), Color(0xFF000000)], // тёмно-красный → чёрный
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Доктор говорит родителям: «У меня новости про вашего малыша». Родители: «Не говорите нам пол, мы хотим сюрприз!» Доктор: «А, понял, вы из тех... Ладно, ОНО не дышит.»',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 80),
              GestureDetector(
                onTap: onArrowTap,
                child: const Icon(Icons.arrow_forward_ios_rounded, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 40),
              const Icon(Icons.favorite, size: 80, color: Colors.pinkAccent),
            ],
          ),
        ),
      ),
    );
  }
}