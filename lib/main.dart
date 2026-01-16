import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/firebase_options.dart';
import 'package:ta_na_escola/services/notification_service.dart';

import 'domain/providers/providers.dart';
import 'shared/utils/routes/app_pages.dart';
import 'shared/utils/routes/route_observer.dart';
import 'theme/custom_themes/theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final notificationService = FirebaseNotificationService();
  await notificationService.init();
  FirebaseMessaging.onBackgroundMessage(handlerOnBackgroundMessage);
  final routeObserver = RouteStackObserver.instance();

  runApp(
    MultiProvider(
      providers: Providers.providers,
      child: MaterialApp(
        title: 'Tá na escola',
        navigatorKey: navigatorKey,
        onGenerateRoute: AppPages.onGenerateRoute,
        navigatorObservers: [routeObserver],
        theme: TneAppTheme.lightTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

@pragma('vm:entry-point')
Future<void> handlerOnBackgroundMessage(RemoteMessage message) async {
  log(message.notification!.title!.toString(), name: 'Notification');
}
