class JackDateFormat {
  static String eventTimeFormat(DateTime date) {
    final day = date.day;
    final month = date.month;
    final year = date.year;
    final hour = date.hour;
    final minutes = date.minute < 10 ? '${date.minute}0' : date.minute;

    final monthName = switch (month) {
      1 => 'Janeiro',
      2 => 'Fevereiro',
      3 => 'Março',
      4 => 'Abril',
      5 => 'Maio',
      6 => 'Junho',
      7 => 'Julho',
      8 => 'Agosto',
      9 => 'Setembro',
      10 => 'Outubro',
      11 => 'Novembro',
      12 => 'Dezembro',
      _ => 'Mês inválido',
    };

    return '$day de $monthName $year $hour:$minutes';
  }

  static DateTime? birthDayFormatter(
    String date, [
    String pattern = '/',
    bool isReverse = false,
  ]) {
    final dateSplits = date
        .split(pattern)
        .map((element) => int.parse(element))
        .toList();
    if (dateSplits.length != 3) return null;

    late int day;
    late int month;
    late int year;

    if (isReverse) {
      day = dateSplits.last;
      month = dateSplits[1];
      year = dateSplits.first;
    } else {
      day = dateSplits.last;
      month = dateSplits[1];
      year = dateSplits.last;
    }
    final handledDate = DateTime(year, month, day);

    return handledDate;
  }

  static String expireTimeFormat(DateTime expireAt) {
    final now = DateTime.now();
    final elapsed = expireAt.difference(now);

    if (elapsed.isNegative) {
      return 'Expirado';
    }
    final handledRemaining = elapsed.toString().split('.').first.padLeft(8, '');
    return 'Expira em $handledRemaining';
  }
}
