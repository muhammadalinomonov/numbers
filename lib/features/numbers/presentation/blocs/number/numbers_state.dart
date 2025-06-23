part of 'numbers_bloc.dart';

@immutable
class NumbersState extends Equatable {
  final FormzSubmissionStatus getNumberStatus;
  final NumberTriviaEntity numberTrivia;
  final InformationTypes selectedCategory;
  final String errorMessage;
  final FormzSubmissionStatus savedNumberStatus;
  final List<NumberTriviaEntity> savedNumbers;
  final FormzSubmissionStatus saveUnSavedNumberStatus;

  const NumbersState({
    this.getNumberStatus = FormzSubmissionStatus.initial,
    this.numberTrivia = const NumberTriviaEntity(),
    this.selectedCategory = InformationTypes.trivia,
    this.errorMessage = '',
    this.savedNumberStatus = FormzSubmissionStatus.initial,
    this.savedNumbers = const [],
    this.saveUnSavedNumberStatus = FormzSubmissionStatus.initial,
  });

  NumbersState copyWith({
    FormzSubmissionStatus? getNumberStatus,
    NumberTriviaEntity? numberTrivia,
    InformationTypes? selectedCategory,
    String? errorMessage,
    FormzSubmissionStatus? savedNumberStatus,
    List<NumberTriviaEntity>? savedNumbers,
    FormzSubmissionStatus? saveUnSavedNumberStatus,
  }) {
    return NumbersState(
      getNumberStatus: getNumberStatus ?? this.getNumberStatus,
      numberTrivia: numberTrivia ?? this.numberTrivia,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      errorMessage: errorMessage ?? this.errorMessage,
      savedNumberStatus: savedNumberStatus ?? this.savedNumberStatus,
      savedNumbers: savedNumbers ?? this.savedNumbers,
      saveUnSavedNumberStatus: saveUnSavedNumberStatus ?? this.saveUnSavedNumberStatus,
    );
  }

  @override
  List<Object> get props => [
        getNumberStatus,
        numberTrivia,
        selectedCategory,
        errorMessage,
        savedNumberStatus,
        savedNumbers,
        saveUnSavedNumberStatus,
      ];
}
