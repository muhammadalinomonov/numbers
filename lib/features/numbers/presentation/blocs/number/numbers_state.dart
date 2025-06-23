part of 'numbers_bloc.dart';

@immutable
class NumbersState extends Equatable {
  final FormzSubmissionStatus getNumberStatus;
  final NumberTriviaEntity numberTrivia;
  final InformationTypes selectedCategory;
  final String errorMessage;

  const NumbersState({
    this.getNumberStatus = FormzSubmissionStatus.initial,
    this.numberTrivia = const NumberTriviaEntity(),
    this.selectedCategory = InformationTypes.trivia,
    this.errorMessage = '',
  });

  NumbersState copyWith({
    FormzSubmissionStatus? getNumberStatus,
    NumberTriviaEntity? numberTrivia,
    InformationTypes? selectedCategory,
    String? errorMessage,
  }) {
    return NumbersState(
      getNumberStatus: getNumberStatus ?? this.getNumberStatus,
      numberTrivia: numberTrivia ?? this.numberTrivia,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        getNumberStatus,
        numberTrivia,
        selectedCategory,
        errorMessage,
      ];
}
