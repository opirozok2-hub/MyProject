// lib/screens/joke_screen2.dart
import 'package:flutter/material.dart';

class JokeScreen2 extends StatelessWidget {
  final VoidCallback onArrowTap;

  const JokeScreen2({super.key, required this.onArrowTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1E90FF), Color(0xFF00BFFF)], // синий → голубой
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
                  'Я сказал жене, что она слишком высоко рисует брови. Она посмотрела на меня удивлённо.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                '😂😂😂',
                style: TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 60),
              GestureDetector(
                onTap: onArrowTap,
                child: const Icon(Icons.arrow_back_ios_rounded, size: 60, color: Colors.black87),
              ),
              const SizedBox(height: 40),
              const Icon(Icons.favorite, size: 80, color: Colors.greenAccent),
            ],
          ),
        ),
      ),
    );
  }
}