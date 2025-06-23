import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:numbers/core/utils/enums.dart';
import 'package:numbers/core/utils/input_convertor.dart';
import 'package:numbers/core/utils/service_locator.dart';
import 'package:numbers/features/numbers/domain/entities/number_trivia_entity.dart';
import 'package:numbers/features/numbers/domain/usecases/get_conrete_number_usecase.dart';
import 'package:numbers/features/numbers/domain/usecases/get_randoom_number_usecase.dart';

part 'numbers_event.dart';
part 'numbers_state.dart';

class NumbersBloc extends Bloc<NumbersEvent, NumbersState> {
  final GetConcreteNumberUseCase getConcreteNumberUseCase = GetConcreteNumberUseCase(repository: serviceLocator.call());
  final GetRandomNumberUseCase getRandomNumberUseCase = GetRandomNumberUseCase(repository: serviceLocator.call());

  NumbersBloc() : super(NumbersState()) {
    on<GetNumberTriviaEvent>(_onGetNumberTrivia);
    on<GetRandomNumberTriviaEvent>(_onGetRandomNumberTrivia);
    on<SelectCategoryEvent>(_onSelectCategory);
  }

  Future<void> _onGetNumberTrivia(GetNumberTriviaEvent event, Emitter<NumbersState> emit) async {
    emit(state.copyWith(getNumberStatus: FormzSubmissionStatus.inProgress));
    final number = InputConvertor().stringToUnsignedInteger(event.numberString, state.selectedCategory);

    if (number.isRight) {
      final result = await getConcreteNumberUseCase.call(NumberTriviaParams(number: number.right, infoType: state.selectedCategory));

      if (result.isRight) {
        emit(
          state.copyWith(
            getNumberStatus: FormzSubmissionStatus.success,
            numberTrivia: result.right,
            selectedCategory: state.selectedCategory,
          ),
        );
        return;
      } else {
        emit(state.copyWith(getNumberStatus: FormzSubmissionStatus.failure, errorMessage: result.left.message));
        return;
      }
    } else {
      emit(state.copyWith(getNumberStatus: FormzSubmissionStatus.failure, errorMessage: number.left.message));
      return;
    }
  }

  Future<void> _onGetRandomNumberTrivia(GetRandomNumberTriviaEvent event, Emitter<NumbersState> emit) async {
    emit(state.copyWith(getNumberStatus: FormzSubmissionStatus.inProgress));
    final result = await getRandomNumberUseCase.call(state.selectedCategory);

    if (result.isRight) {
      emit(state.copyWith(
          getNumberStatus: FormzSubmissionStatus.success,
          numberTrivia: result.right,
          selectedCategory: state.selectedCategory));
    } else {
      emit(state.copyWith(getNumberStatus: FormzSubmissionStatus.failure, errorMessage: result.left.message));
    }
  }

  Future<void> _onSelectCategory(SelectCategoryEvent event, Emitter<NumbersState> emit) async {
    emit(state.copyWith(selectedCategory: event.informationType));
  }
}
