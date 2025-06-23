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
