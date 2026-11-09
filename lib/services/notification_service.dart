import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../app_keys.dart';
import '../firebase_options.dart';

// Handler untuk notifikasi saat aplikasi background/terminated.
// Fungsi harus berada di luar class.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  debugPrint('[BACKGROUND] ${message.notification?.title}');

  debugPrint('[BACKGROUND] ${message.notification?.body}');
}

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Mengambil FCM Token.
  Future<String?> getToken() async {
    final token = await _messaging.getToken();

    debugPrint('FCM Token: $token');

    return token;
  }

  // Mendengarkan perubahan token.
  void listenTokenRefresh(void Function(String token) onRefresh) {
    _messaging.onTokenRefresh.listen((newToken) {
      debugPrint('FCM Token diperbarui');

      onRefresh(newToken);
    });
  }

  // Meminta izin notifikasi.
  Future<void> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint('Status izin notifikasi: ${settings.authorizationStatus}');
  }

  // Inisialisasi layanan notifikasi.
  Future<void> init() async {
    await requestPermission();

    // Mengambil token perangkat.
    await getToken();

    // Memantau perubahan token.
    listenTokenRefresh((newToken) {
      debugPrint('FCM Token terbaru diterima');
    });

    // Pengaturan notifikasi foreground untuk iOS.
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Listener ketika aplikasi sedang terbuka.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('[FOREGROUND] Notification received');

      debugPrint('title: ${message.notification?.title}');

      debugPrint('body: ${message.notification?.body}');

      debugPrint('data: ${message.data}');

      // Menampilkan notifikasi melalui SnackBar.
      final title = message.notification?.title ?? 'Notifikasi';

      final body = message.notification?.body ?? '';

      messengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('$title\n$body'),
          duration: const Duration(seconds: 5),
        ),
      );
    });
  }
}
