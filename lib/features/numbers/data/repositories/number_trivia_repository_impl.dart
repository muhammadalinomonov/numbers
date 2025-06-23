import 'package:dio/dio.dart';
import 'package:numbers/core/errors/failures.dart';
import 'package:numbers/core/utils/either.dart';
import 'package:numbers/core/utils/enums.dart';
import 'package:numbers/features/numbers/data/datasources/numbers_local_datasource.dart';
import 'package:numbers/features/numbers/data/datasources/numbers_remote_datasource.dart';
import 'package:numbers/features/numbers/domain/entities/number_trivia_entity.dart';
import 'package:numbers/features/numbers/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl extends NumberTriviaRepository {
  final NumbersRemoteDataSource remoteDataSource;
  final NumbersLocalDataSource localDataSource;

  NumberTriviaRepositoryImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, NumberTriviaEntity>> getConcreteNumberTrivia({
    required String number,
    required InformationTypes infoType,
  }) async {
    try {
      final trivia = await remoteDataSource.getConcreteNumberTrivia(
        number: number,
        informationType: infoType,
      );

      // cache locally
      await localDataSource.cacheNumberTrivia(trivia.number, trivia.text, infoType.key, number);

      return Right(trivia);
    } on DioException {
      try {
        final cached = await localDataSource.getLastNumberTrivia(number: number, category: infoType);
        return Right(cached);
      } catch (e) {
        return Left(DioFailure(message: 'No internet and no cached data found.'));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, NumberTriviaEntity>> getRandomNumberTrivia({required InformationTypes infoType}) async {
    try {
      final trivia = await remoteDataSource.getRandomNumberTrivia(informationType: infoType);

      // cache locally
      await localDataSource.cacheNumberTrivia(trivia.number, trivia.text, infoType.key ?? '', trivia.number.toString());
      return Right(trivia);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DioException {
      // If there's a DioException, we can assume no internet connection
      try {
        final cached = await localDataSource.getRandomNumberTrivia(category: infoType);
        return Right(cached);
      } catch (e) {
        return Left(DioFailure(message: 'No internet and no cached data found.'));
      }
    } catch (e) {
      return Left(ServerFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> saveNumberTrivia(
      {required NumberTriviaEntity trivia, required InformationTypes infoType}) async {
    try {
      final result = await localDataSource.saveNumberTrivia(
        trivia.number,
        trivia.text,
        infoType.key ?? '',
        trivia.number.toString(),
      );

      return Right(result);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to save trivia: $e'));
    }
  }

  @override
  Future<Either<Failure, List<NumberTriviaEntity>>> getSavedNumbers() async {
    try {
      final savedNumbers = await localDataSource.getAllSavedNumberTrivia();
      return Right(savedNumbers);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to retrieve saved numbers: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSavedNumber({required NumberTriviaEntity trivia}) async {
    try {
      final result = await localDataSource.unSaveNumberTrivia(trivia.id);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to delete saved number: $e'));
    }
  }
}
