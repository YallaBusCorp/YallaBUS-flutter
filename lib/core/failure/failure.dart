class Failure {
  late String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure({String? message}) : super(message!);
}

class CacheFailure extends Failure {
  CacheFailure({String? message}) : super(message!);
}

class NetworkFailure extends Failure {
  NetworkFailure({String? message}) : super(message!);
}

class VerificationFailure extends Failure {
  VerificationFailure({String? message}) : super(message!);
}
