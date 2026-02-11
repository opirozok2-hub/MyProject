import 'package:local_notifier/local_notifier.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  Future<void> initialize() async {
    await localNotifier.setup(
      appName: 'Joke App',
      shortcutPolicy: ShortcutPolicy.requireCreate,
    );
  }

  Future<void> showJokeNotification(String joke) async {
    LocalNotification notification = LocalNotification(
      title: 'Новая шутка загружена',
      body: joke.length > 100 ? '${joke.substring(0, 100)}...' : joke,
    );
    notification.show();
  }

  Future<void> showErrorNotification() async {
    LocalNotification notification = LocalNotification(
      title: 'Ошибка',
      body: 'Не удалось загрузить шутку',
    );
    notification.show();
  }
}