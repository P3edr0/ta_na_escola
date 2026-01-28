import 'package:flutter/material.dart';
import 'package:ta_na_escola/presenter/auth/create_password/create_password_page.dart';
import 'package:ta_na_escola/presenter/auth/credential/credential_page.dart';
import 'package:ta_na_escola/presenter/auth/face_detector/face_capture_page.dart';
import 'package:ta_na_escola/presenter/auth/login/login_page.dart';
import 'package:ta_na_escola/presenter/auth/pre_face_capture/pre_face_capture_page.dart';
import 'package:ta_na_escola/presenter/auth/preview_face_capture/preview_captured_face_page.dart';
import 'package:ta_na_escola/presenter/auth/recover_password/help_page.dart';
import 'package:ta_na_escola/presenter/auth/recover_password/password_recover_email_page.dart';
import 'package:ta_na_escola/presenter/auth/recover_password/password_recover_page.dart';
import 'package:ta_na_escola/presenter/auth/recovery_session/recovery_sesion_page.dart';
import 'package:ta_na_escola/presenter/auth/without_account/without_account_page.dart';
import 'package:ta_na_escola/presenter/features/frequency/pages/fault/fault_page.dart';
import 'package:ta_na_escola/presenter/features/frequency/pages/frequency/frequency_page.dart';
import 'package:ta_na_escola/presenter/features/home/home_page.dart';
import 'package:ta_na_escola/presenter/features/notification/notification_page.dart';
import 'package:ta_na_escola/presenter/features/splash/bloc_app_page.dart';
import 'package:ta_na_escola/presenter/features/splash/splash_page.dart';
import 'package:ta_na_escola/presenter/features/splash/update_app_page.dart';

import '../../../presenter/features/notification/notification_details_page.dart';
import 'app_routes.dart';

class AppPages {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case == TneRoutes.splash:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case == TneRoutes.credential:
        return MaterialPageRoute(builder: (_) => CredentialPage());
      case == TneRoutes.createPassword:
        return MaterialPageRoute(builder: (_) => CreatePasswordPage());
      case == TneRoutes.preFaceCapture:
        return MaterialPageRoute(builder: (_) => PreFaceCapturePage());
      case == TneRoutes.previewFaceCapture:
        return MaterialPageRoute(builder: (_) => PreviewCapturedFacePage());
      case == TneRoutes.withoutAccount:
        return MaterialPageRoute(builder: (_) => WithoutAccountPage());
      case == TneRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case == TneRoutes.home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case == TneRoutes.faceCapture:
        return MaterialPageRoute(builder: (_) => FaceCapturePage());
      case == TneRoutes.passwordRecover:
        return MaterialPageRoute(builder: (_) => PasswordRecoverPage());
      case == TneRoutes.passwordRecoverEmail:
        return MaterialPageRoute(builder: (_) => PasswordRecoverEmailPage());
      case == TneRoutes.passwordRecoverHelp:
        return MaterialPageRoute(builder: (_) => HelpPage());
      case == TneRoutes.frequency:
        return MaterialPageRoute(builder: (_) => FrequencyPage());
      case == TneRoutes.recoverSession:
        return MaterialPageRoute(builder: (_) => RecoverySessionPage());
      case == TneRoutes.fault:
        return MaterialPageRoute(builder: (_) => FaultPage());
      case == TneRoutes.notification:
        return MaterialPageRoute(builder: (_) => NotificationPage());
      case == TneRoutes.notificationDetails:
        return MaterialPageRoute(builder: (_) => NotificationDetailsPage());
      case == TneRoutes.updateApp:
        return MaterialPageRoute(builder: (_) => UpdateAppPage());
      case == TneRoutes.blockApp:
        return MaterialPageRoute(builder: (_) => BlocAppPage());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Rota não encontrada'))),
        );
    }
  }
}
