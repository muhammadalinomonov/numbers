import 'package:numbers/core/utils/either.dart';
import 'package:numbers/core/errors/failures.dart';

import 'package:numbers/core/utils/enums.dart';
import 'package:numbers/features/numbers/domain/entities/number_trivia_entity.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTriviaEntity>> getConcreteNumberTrivia(
      {required String number, InformationTypes? infoType});

  Future<Either<Failure, NumberTriviaEntity>> getRandomNumberTrivia({InformationTypes? infoType});
}
