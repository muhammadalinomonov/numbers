import 'package:get_it/get_it.dart';
import 'package:numbers/core/network/dio_options.dart';
import 'package:numbers/features/numbers/data/datasources/numbers_local_datasource.dart';
import 'package:numbers/features/numbers/data/datasources/numbers_remote_datasource.dart';
import 'package:numbers/features/numbers/data/repositories/number_trivia_repository_impl.dart';
import 'package:numbers/features/numbers/domain/repositories/number_trivia_repository.dart';

final serviceLocator = GetIt.instance;

Future<void> registerServiceLocator() async {
  ///core
  serviceLocator.registerLazySingleton(() => DioOptions().dio);

  ///data sources
  serviceLocator
      .registerLazySingleton<NumbersRemoteDataSource>(() => NumbersRemoteDataSourceImpl(dio: serviceLocator.call()));

  serviceLocator.registerLazySingleton<NumbersLocalDataSource>(
    () => NumbersLocalDataSourceImpl(),
  );

  ///repositories
  serviceLocator.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRepositoryImpl(remoteDataSource: serviceLocator.call(), localDataSource: serviceLocator.call()));
}
