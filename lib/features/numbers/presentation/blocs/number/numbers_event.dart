part of 'numbers_bloc.dart';

@immutable
sealed class NumbersEvent {}

class GetNumberTriviaEvent extends NumbersEvent {
  final String numberString;

  GetNumberTriviaEvent(this.numberString);
}

class GetRandomNumberTriviaEvent extends NumbersEvent {
  GetRandomNumberTriviaEvent();
}

class SelectCategoryEvent extends NumbersEvent {
  final InformationTypes informationType;

  SelectCategoryEvent(this.informationType);
}

class SaveNumberTriviaEvent extends NumbersEvent {
  final NumberTriviaEntity number;
  final bool isSaved;
  final VoidCallback onSuccess;
  final VoidCallback onError;

  SaveNumberTriviaEvent({
    required this.isSaved,
    required this.number,
    required this.onSuccess,
    required this.onError,
  });
}


class GetSavedNumberTriviaEvent extends NumbersEvent {
}