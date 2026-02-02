import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationService {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> createLocalNotificationChannel() async {
    const AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
          'high_importance_channel',
          'High Importance Notifications',
          description: 'This channel is used for important notifications',
          importance: Importance.high,
        );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  Future<void> init() async {
    final permission = await _firebaseMessaging.requestPermission();
    if (permission.authorizationStatus == AuthorizationStatus.denied) {
      throw Exception("O usuário recusou receber notificações.");
    }

    await getToken();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log(message.notification!.title!.toString(), name: 'Notification');
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        AndroidNotificationDetails? androidPlatformChannelSpecifics;
        if (Platform.isAndroid && message.notification?.android != null) {
          androidPlatformChannelSpecifics = AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          );
        }

        DarwinNotificationDetails? iosPlatformChannelSpecifics;
        if (Platform.isIOS) {
          iosPlatformChannelSpecifics = DarwinNotificationDetails(
            presentAlert: true, // Mostra alerta
            presentBadge: true, // Atualiza badge
            presentSound: true, // Toca som
          );
        }

        // Exibir notificação com configurações específicas da plataforma
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: androidPlatformChannelSpecifics,
            iOS: iosPlatformChannelSpecifics, // <-- ADICIONADO
          ),
        );
      }
    });

    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings
    darwinInitializationSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
      //   // Lógica opcional quando uma notificação local é recebida no iOS
      //   log('Notificação local recebida no iOS: $title', name: 'NotificationService');
      // },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: androidInitializationSettings,
          iOS: darwinInitializationSettings,
        );
    // NOVO: Configuração para iOS
    // Apenas solicita permissão para exibir alertas, sons e badges.

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,

      onDidReceiveBackgroundNotificationResponse: _onNotificationTap,
    );

    await createLocalNotificationChannel();
  }

  Future<String?> getToken() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final isIos = Platform.isIOS;

    if (isIos) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      if (!iosInfo.isPhysicalDevice) return 'emulator_ios_token';
    }
    final token = await _firebaseMessaging.getToken();
    log(token.toString(), name: 'Token');
    return token;
  }

  static void _onNotificationTap(NotificationResponse details) {
    log('Notificação tocada: ${details.payload}', name: 'NotificationService');
    // Aqui você pode navegar para uma tela específica
  }
}
