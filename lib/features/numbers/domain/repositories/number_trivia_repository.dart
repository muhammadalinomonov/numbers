import 'package:numbers/core/errors/failures.dart';
import 'package:numbers/core/utils/either.dart';
import 'package:numbers/core/utils/enums.dart';
import 'package:numbers/features/numbers/domain/entities/number_trivia_entity.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTriviaEntity>> getConcreteNumberTrivia(
      {required String number, required InformationTypes infoType});

  Future<Either<Failure, NumberTriviaEntity>> getRandomNumberTrivia({required InformationTypes infoType});

  Future<Either<Failure, void>> saveNumberTrivia({required NumberTriviaEntity trivia, required InformationTypes infoType});

  Future<Either<Failure, List<NumberTriviaEntity>>> getSavedNumbers();

  Future<Either<Failure, void>> deleteSavedNumber({required NumberTriviaEntity trivia});
}
