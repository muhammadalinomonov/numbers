import 'package:numbers/core/utils/either.dart';
import 'package:numbers/core/errors/failures.dart';

abstract class UseCase<Type, NoParams> {
  Future<Either<Failure, Type>> call(NoParams params);
}
class NoParams {}