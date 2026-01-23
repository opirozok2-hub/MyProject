// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/joke_screen1.dart';
import 'screens/joke_screen2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke Design',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // 0 — первая шутка, 1 — вторая

  void _switchJoke(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Основной контент с градиентом
          _currentIndex == 0
              ? JokeScreen1(onArrowTap: () => _switchJoke(1))
              : JokeScreen2(onArrowTap: () => _switchJoke(0)),

          // Меню (три полоски) в правом верхнем углу
          Positioned(
            top: 40,   // отступ от верхнего края экрана
            right: 20, // отступ справа
            child: PopupMenuButton<int>(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 32,
              ),
              color: Colors.black.withOpacity(0.8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onSelected: _switchJoke,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text('Шутка 1', style: TextStyle(color: Colors.white)),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('Шутка 2', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}