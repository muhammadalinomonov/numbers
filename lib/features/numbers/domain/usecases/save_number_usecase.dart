import 'package:numbers/core/errors/failures.dart';
import 'package:numbers/core/usecases/usecase.dart';
import 'package:numbers/core/utils/either.dart';
import 'package:numbers/core/utils/enums.dart';
import 'package:numbers/features/numbers/domain/entities/number_trivia_entity.dart';
import 'package:numbers/features/numbers/domain/repositories/number_trivia_repository.dart';

class SaveNumberUseCase implements UseCase<void, SaveNumberTriviaParams> {
  final NumberTriviaRepository repository;

  SaveNumberUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(SaveNumberTriviaParams params) async {
    return repository.saveNumberTrivia(infoType: params.infoType, trivia: params.trivia);
  }
}

class SaveNumberTriviaParams {
  final NumberTriviaEntity trivia;
  final InformationTypes infoType;

  SaveNumberTriviaParams({required this.trivia, required this.infoType});
}
