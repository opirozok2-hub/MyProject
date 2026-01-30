import 'package:flutter/material.dart';
import '../services/joke_service.dart';

class JokeScreen1 extends StatefulWidget {
  final VoidCallback onArrowTap;
  const JokeScreen1({super.key, required this.onArrowTap});

  @override
  State<JokeScreen1> createState() => _JokeScreen1State();
}

class _JokeScreen1State extends State<JokeScreen1> {
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
    final joke = await _service.fetchDark();
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
          colors: [Color(0xFF8B0000), Color(0xFF000000)],
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
                          color: Colors.white,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
              const SizedBox(height: 80),

              /// переход на обычные шутки
              GestureDetector(
                onTap: widget.onArrowTap,
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 60,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 40),

              /// ❤️ обновление шутки
              GestureDetector(
                onTap: _loadJoke,
                child: const Icon(
                  Icons.favorite,
                  size: 80,
                  color: Colors.pinkAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
