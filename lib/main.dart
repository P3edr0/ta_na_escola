import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/providers/providers.dart';
import 'firebase_options.dart';
import 'services/notification_service.dart';
import 'shared/utils/routes/app_pages.dart';
import 'shared/utils/routes/route_observer.dart';
import 'theme/custom_themes/theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      // 1. INICIALIZAÇÕES DENTRO DA ZONA
      WidgetsFlutterBinding.ensureInitialized();
      
      // 2. CONFIGURAÇÕES DO FIREBASE
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      
      // 3. CONFIGURAÇÕES DE CRASHLYTICS
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
      
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
      
      // 4. CONFIGURAÇÕES DE NOTIFICAÇÃO
      final notificationService = FirebaseNotificationService();
      await notificationService.init();
      FirebaseMessaging.onBackgroundMessage(handlerOnBackgroundMessage);
      
      // 5. OBSERVER DE ROTA
      final routeObserver = RouteStackObserver.instance();
      
      // 6. RUN APP
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
    },
    // 7. HANDLER DE ERROS DA ZONA
    (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    },
  );
}

@pragma('vm:entry-point')
Future<void> handlerOnBackgroundMessage(RemoteMessage message) async {
  log(message.notification!.title!.toString(), name: 'Notification');
}