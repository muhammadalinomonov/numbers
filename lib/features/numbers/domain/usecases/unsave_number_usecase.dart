import 'package:numbers/core/errors/failures.dart';
import 'package:numbers/core/usecases/usecase.dart';
import 'package:numbers/core/utils/either.dart';
import 'package:numbers/core/utils/enums.dart';
import 'package:numbers/features/numbers/domain/entities/number_trivia_entity.dart';
import 'package:numbers/features/numbers/domain/repositories/number_trivia_repository.dart';

class UnSaveNumberUseCase implements UseCase<void, NumberTriviaEntity> {
  final NumberTriviaRepository repository;

  UnSaveNumberUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(NumberTriviaEntity params) async {
    return repository.deleteSavedNumber(trivia: params);
  }
}