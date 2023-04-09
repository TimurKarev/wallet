import 'package:dartz/dartz.dart';
import 'package:wallet/domain/entities/failures/auth_failure.dart';
import 'package:wallet/domain/entities/user/app_user.dart';

abstract class AuthRepository {
  Stream<Option<AppUser>> getWalletUser();
  Future<Either<AuthFailure, Unit>> signInAnonymously();
  Future<Either<AuthFailure, Unit>> signOut();
}
