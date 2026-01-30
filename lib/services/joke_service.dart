import 'dart:convert';
import 'package:http/http.dart' as http;

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
}
