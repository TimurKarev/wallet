import 'package:dartz/dartz.dart';
import 'package:wallet/domain/entities/failures/auth_failure.dart';

abstract class SignInUseCase {
  Future<Either<AuthFailure, Unit>> signIn();
}
