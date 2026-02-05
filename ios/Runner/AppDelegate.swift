import UIKit
import Flutter
import Firebase // 1. Importa Firebase Core
import FirebaseMessaging // 2. Importa Firebase Messaging
import UserNotifications // 3. Importa o framework de notificações da Apple

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // 🔥 CONFIGURAÇÃO CRÍTICA PARA NOTIFICAÇÕES PUSH
    // ------------------------------------------------------------
    
    // A. Configura o Firebase (DEVE vir antes do registro)
    FirebaseApp.configure()
    
    // B. Configura o delegado das notificações
    //    Isso permite que seu app responda a notificações em foreground
    UNUserNotificationCenter.current().delegate = self
    
    // C. Solicita permissão AO SISTEMA para notificações remotas
    //    Este é o chamado que faz o iOS gerar o token APNS
    application.registerForRemoteNotifications()
    
    // ------------------------------------------------------------
    // FIM DA CONFIGURAÇÃO CRÍTICA
    
    // Registra os plugins do Flutter (não mexa nesta linha)
    GeneratedPluginRegistrant.register(with: self)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // MARK: - Métodos de Token APNS (ESSENCIAIS)
  
  /// Este método é chamado automaticamente pelo iOS quando o
  /// token APNS é gerado com SUCESSO.
  override func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    // 1. Converte o token binário para string (para debug)
    let tokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
    print("✅ TOKEN APNS GERADO PELO iOS: \(tokenString)")
    
    // 2. ENVIA o token para o Firebase Messaging
    //    Esta linha é OBRIGATÓRIA para o getAPNSToken() funcionar no Flutter
    Messaging.messaging().apnsToken = deviceToken
    
    // 3. Chama a implementação da classe pai
    super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }
  
  /// Este método é chamado se o REGISTRO FALHAR.
  /// Adicione para debug, mas não é obrigatório.
  override func application(
    _ application: UIApplication,
    didFailToRegisterForRemoteNotificationsWithError error: Error
  ) {
    print("❌ FALHA AO REGISTRAR PARA NOTIFICAÇÕES: \(error.localizedDescription)")
    print("   Verifique: Certificados Push, Provisioning Profile, conectividade")
  }
}