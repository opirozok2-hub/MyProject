import 'package:flutter/material.dart';
import '../services/joke_service.dart';

class JokeScreen2 extends StatefulWidget {
  final VoidCallback onArrowTap;
  const JokeScreen2({super.key, required this.onArrowTap});

  @override
  State<JokeScreen2> createState() => _JokeScreen2State();
}

class _JokeScreen2State extends State<JokeScreen2> {
  final JokeService _service = JokeService();
  Joke? _joke;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadJoke();
  }

  Future<void> _loadJoke() async {
    setState(() => _loading = true);
    final joke = await _service.fetchNormal();
    setState(() {
      _joke = joke;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1E90FF), Color(0xFF00BFFF)],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _loading
                    ? const CircularProgressIndicator()
                    : Text(
                        _joke?.render() ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
              const SizedBox(height: 40),

              /// назад к dark
              GestureDetector(
                onTap: widget.onArrowTap,
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 60,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 40),

              /// ❤️ обновление шутки
              GestureDetector(
                onTap: _loadJoke,
                child: const Icon(
                  Icons.favorite,
                  size: 80,
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
