import 'package:numbers/core/utils/either.dart';
import 'package:numbers/core/errors/failures.dart';
import 'package:numbers/core/utils/enums.dart';

class InputConvertor {
  Either<Failure, String> stringToUnsignedInteger(String str, InformationTypes infoType) {
    try {
      if(infoType == InformationTypes.date){
        final dateParts = str.split('/');
        if (dateParts.length != 2) throw const FormatException();
        for (var part in dateParts) {
          if (int.tryParse(part) == null || int.parse(part) < 0) {
            throw const FormatException();
          }
        }
        return Right(str);
      }
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return Right(integer.toString());
    } on FormatException {
      return Left(InvalidInputFailure(message: 'Число должно быть в виде цифры'));
    } catch (e) {
      return Left(InvalidInputFailure(message: 'Число должно быть в виде цифры'));
    }
  }
}
