abstract class Failure {
  final String message;

  Failure({required this.message});
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType && other is Failure;
  }

  @override
  int get hashCode {
    return runtimeType.hashCode;
  }
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}

class CacheFailure extends Failure {
  CacheFailure({required super.message});
}

class InvalidInputFailure extends Failure {
  InvalidInputFailure({required super.message});
}

class DioFailure extends Failure {
  DioFailure({required super.message});
}