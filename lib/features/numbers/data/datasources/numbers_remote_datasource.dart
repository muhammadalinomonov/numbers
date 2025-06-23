import 'package:dio/dio.dart';
import 'package:numbers/core/errors/exeptions.dart';
import 'package:numbers/core/utils/enums.dart';
import 'package:numbers/features/numbers/data/models/number_trivia_model.dart';

abstract class NumbersRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia({required String number, InformationTypes? informationType});

  Future<NumberTriviaModel> getRandomNumberTrivia({InformationTypes? informationType});
}

class NumbersRemoteDataSourceImpl implements NumbersRemoteDataSource {
  final Dio dio;

  NumbersRemoteDataSourceImpl({required this.dio});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia({required String number, InformationTypes? informationType}) async {
    try {

      final endPoint = informationType == InformationTypes.date
          ? '/date'
          : informationType == InformationTypes.math
              ? '/math'
              : '';
      final response = await dio.get(
        '$number$endPoint',

      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return Future.value(NumberTriviaModel.fromJson(response.data));
      } else {
        throw ServerException('Failed to fetch trivia for number $number');
      }
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      throw ServerException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia({InformationTypes? informationType}) async {
    try {
      final endPoint = informationType == InformationTypes.date
          ? '/date'
          : informationType == InformationTypes.math
          ? '/math'
          : '/trivia';
      final response = await dio.get(
        '/random$endPoint',
      );


      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return Future.value(NumberTriviaModel.fromJson(response.data));
      } else {
        throw ServerException('Failed to fetch random trivia');
      }
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      throw ServerException('An unexpected error occurred: $e');
    }
  }
}
