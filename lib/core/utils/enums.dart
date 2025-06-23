enum InformationTypes {
  trivia,
  math,
  date;

  String get key {
    switch (this) {
      case InformationTypes.trivia:
        return 'trivia';
      case InformationTypes.math:
        return 'math';
      case InformationTypes.date:
        return 'date';
    }
  }

  factory InformationTypes.fromString(String value) {
    switch (value.toLowerCase()) {
      case 'trivia':
        return InformationTypes.trivia;
      case 'math':
        return InformationTypes.math;
      case 'date':
        return InformationTypes.date;
      default:
        throw ArgumentError('Invalid information type: $value');
    }
  }
}
