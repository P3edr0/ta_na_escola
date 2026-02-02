import '../app_assets.dart';

enum NotificationCategory {
  directory,
  frequency,
  activity,
  utility,
  teacher,
  occurrence,
  newsAndEvents;

  bool get isDirectory => this == directory;
  bool get isFrequency => this == frequency;
  bool get isNewsAndEvents => this == newsAndEvents;
  bool get isUtility => this == utility;
  bool get isActivity => this == activity;
  bool get isOccurrence => this == occurrence;
  bool get isTeacher => this == teacher;

  String getImage() {
    switch (this) {
      case directory:
        return TneAppAssets.directory;
      case occurrence:
        return TneAppAssets.directory;
      case teacher:
        return TneAppAssets.directory;

      case frequency:
        return TneAppAssets.frequency;

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

      case teacher:
        return 'Professor';
      case occurrence:
        return 'Ocorrências';

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

      case 'Ocorrências':
        return occurrence;
      case 'Professor':
        return teacher;

      case 'Atividades':
        return activity;

      case 'Utilidade':
        return utility;

      default:
        return newsAndEvents;
    }
  }
}
