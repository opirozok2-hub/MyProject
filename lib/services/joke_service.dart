import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Joke {
  final String type;
  final String? joke;
  final String? setup;
  final String? delivery;

  Joke({
    required this.type,
    this.joke,
    this.setup,
    this.delivery,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      type: json['type'],
      joke: json['joke'],
      setup: json['setup'],
      delivery: json['delivery'],
    );
  }

  String render() {
    if (type == 'single') return joke ?? '';
    return '${setup ?? ''}\n\n${delivery ?? ''}';
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'joke': joke,
      'setup': setup,
      'delivery': delivery,
    };
  }
}

class JokeService {
  static const _base = 'https://v2.jokeapi.dev/joke';

  Future<Joke> fetchDark() async {
    final uri = Uri.parse(
      '$_base/Dark?blacklistFlags=nsfw,religious,political,racist,sexist,explicit',
    );
    final res = await http.get(uri);
    if (res.statusCode != 200) throw Exception('HTTP ${res.statusCode}');
    return Joke.fromJson(jsonDecode(res.body));
  }

  Future<Joke> fetchNormal() async {
    final uri = Uri.parse('$_base/Any?safe-mode');
    final res = await http.get(uri);
    if (res.statusCode != 200) throw Exception('HTTP ${res.statusCode}');
    return Joke.fromJson(jsonDecode(res.body));
  }

  // New: Cache joke
  Future<void> cacheJoke(String key, Joke joke) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(joke.toJson()));
  }

  // New: Load cached joke
  Future<Joke?> loadCachedJoke(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      return Joke.fromJson(jsonDecode(jsonString));
    }
    return null;
  }
}