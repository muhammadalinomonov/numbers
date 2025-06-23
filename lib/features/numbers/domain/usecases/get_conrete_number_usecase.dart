import 'package:numbers/core/utils/either.dart';
import 'package:numbers/core/errors/failures.dart';
import 'package:numbers/core/usecases/usecase.dart';
import 'package:numbers/core/utils/enums.dart';
import 'package:numbers/features/numbers/domain/entities/number_trivia_entity.dart';
import 'package:numbers/features/numbers/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberUseCase implements UseCase<NumberTriviaEntity, NumberTriviaParams> {
  final NumberTriviaRepository repository;

  GetConcreteNumberUseCase({required this.repository});

  @override
  Future<Either<Failure, NumberTriviaEntity>> call(NumberTriviaParams params) async {
    return repository.getConcreteNumberTrivia(number: params.number, infoType: params.infoType);
  }
}

class NumberTriviaParams {
  final String number;
  final InformationTypes? infoType;

  NumberTriviaParams({required this.number, this.infoType});
}
