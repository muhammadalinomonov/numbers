import 'package:numbers/core/utils/either.dart';
import 'package:numbers/core/errors/failures.dart';
import 'package:numbers/core/usecases/usecase.dart';
import 'package:numbers/core/utils/enums.dart';
import 'package:numbers/features/numbers/domain/entities/number_trivia_entity.dart';
import 'package:numbers/features/numbers/domain/repositories/number_trivia_repository.dart';

class GetSavedNumbersUseCase implements UseCase<List<NumberTriviaEntity>, NoParams> {
  final NumberTriviaRepository repository;

  GetSavedNumbersUseCase({required this.repository});

  @override
  Future<Either<Failure, List<NumberTriviaEntity>>> call(NoParams params) async {
    return repository.getSavedNumbers();
  }
}
