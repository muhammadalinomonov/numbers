import 'package:dio/dio.dart';
import 'package:numbers/core/errors/failures.dart';
import 'package:numbers/core/utils/either.dart';
import 'package:numbers/core/utils/enums.dart';
import 'package:numbers/features/numbers/data/datasources/numbers_remote_datasource.dart';
import 'package:numbers/features/numbers/domain/entities/number_trivia_entity.dart';
import 'package:numbers/features/numbers/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl extends NumberTriviaRepository {
  final NumbersRemoteDataSource remoteDataSource;

  NumberTriviaRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, NumberTriviaEntity>> getConcreteNumberTrivia(
      {required String number, InformationTypes? infoType}) async {
    try {
      final trivia = await remoteDataSource.getConcreteNumberTrivia(number: number, informationType: infoType);
      return Right(trivia);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DioException {
      return Left(DioFailure(message: 'No internet connection, try again later.'));
    } catch (e) {
      return Left(ServerFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, NumberTriviaEntity>> getRandomNumberTrivia({InformationTypes? infoType}) async {
    try {
      final trivia = await remoteDataSource.getRandomNumberTrivia(informationType: infoType);
      return Right(trivia);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DioException {
      return Left(DioFailure(message: 'No internet connection, try again later.'));
    } catch (e) {
      return Left(ServerFailure(message: 'An unexpected error occurred: $e'));
    }
  }
}
