import 'package:dartz/dartz.dart';
import 'package:wallet/domain/entities/failures/auth_failure.dart';
import 'package:wallet/domain/repositories/auth/auth_repository.dart';
import 'package:wallet/domain/use_cases/auth/sign_in_use_case.dart';

class FirebaseGuestSignInUseCase extends SignInUseCase {
  FirebaseGuestSignInUseCase(this._repo);

  final AuthRepository _repo;

  @override
  Future<Either<AuthFailure, Unit>> signIn() async => _repo.signInAnonymously();
}
