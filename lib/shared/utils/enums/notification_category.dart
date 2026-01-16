import '../app_assets.dart';

enum NotificationCategory {
  directory,
  frequency,
  system,
  activity,
  utility,
  newsAndEvents;

  bool get isDirectory => this == directory;
  bool get isFrequency => this == frequency;
  bool get isSystem => this == system;
  bool get isNewsAndEvents => this == newsAndEvents;
  bool get isUtility => this == utility;
  bool get isActivity => this == activity;

  String getImage() {
    switch (this) {
      case directory:
        return TneAppAssets.directory;

      case frequency:
        return TneAppAssets.frequency;

      case system:
        return TneAppAssets.notifyAppLogo;

      case activity:
        return TneAppAssets.activity;

      case utility:
        return TneAppAssets.utility;

      case newsAndEvents:
        return TneAppAssets.news;
    }
  }

  String getTitle() {
    switch (this) {
      case directory:
        return 'Diretoria';

      case frequency:
        return 'Entradas e saídas';

      case system:
        return 'Tá na Escola';

      case activity:
        return 'Atividades';

      case utility:
        return 'Utilidades';

      case newsAndEvents:
        return 'Notícias/Eventos';
    }
  }

  static NotificationCategory translate(String value) {
    switch (value) {
      case 'Diretoria':
        return directory;

      case 'Entradas e Saídas':
        return frequency;

      case 'Tá na Escola':
        return system;

      case 'Atividades':
        return activity;

      case 'Utilidade':
        return utility;

      default:
        return newsAndEvents;
    }
  }
}
