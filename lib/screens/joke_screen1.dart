import 'package:flutter/material.dart';
import '../services/joke_service.dart';
import '../services/notification_service.dart';

class JokeScreen1 extends StatefulWidget {
  final VoidCallback onArrowTap;
  const JokeScreen1({super.key, required this.onArrowTap});

  @override
  State<JokeScreen1> createState() => _JokeScreen1State();
}

class _JokeScreen1State extends State<JokeScreen1> {
  final JokeService _service = JokeService();
  final NotificationService _notificationService = NotificationService();
  Joke? _joke;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadJoke();
  }

  Future<void> _loadJoke() async {
    setState(() => _loading = true);

    final cachedJoke = await _service.loadCachedJoke('dark_joke');
    if (cachedJoke != null) {
      setState(() {
        _joke = cachedJoke;
        _loading = false;
      });
    }

    try {
      final newJoke = await _service.fetchDark();
      await _service.cacheJoke('dark_joke', newJoke);
      setState(() {
        _joke = newJoke;
        _loading = false;
      });
      await _notificationService.showJokeNotification(newJoke.render());
    } catch (e) {
      if (cachedJoke == null) {
        setState(() => _loading = false);
        await _notificationService.showErrorNotification();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка загрузки: $e. Нет кэша.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Использую кэш (оффлайн)')),
        );
      }
    }
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
                        _joke?.render() ?? 'Нет шутки',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
              const SizedBox(height: 80),
              GestureDetector(
                onTap: widget.onArrowTap,
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
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