import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallet/domain/entities/failures/auth_failure.dart';
import 'package:wallet/domain/entities/user/app_user.dart';
import 'package:wallet/domain/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth;

  FirebaseAuthRepository({required FirebaseAuth auth}) : _auth = auth;

  @override
  Stream<Option<AppUser>> getWalletUser() {
    // Use the Firebase Auth instance to listen for changes in the authentication state
    return _auth.authStateChanges().map(
          (user) => user == null
              ? none()
              : some(
                  AppUser(
                    id: user.uid,
                    email: user.email ?? '',
                  ),
                ),
        );
  }

  @override
  Future<Either<AuthFailure, Unit>> signInAnonymously() async {
    try {
      final UserCredential result = await _auth.signInAnonymously();
      final User? user = result.user;
      if (user != null) {
        return right(unit);
      } else {
        return left(const AuthFailure.signInFailure());
      }
    } catch (e) {
      // Handle any errors that occur during sign in
      return left(const AuthFailure.signInFailure());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      await _auth.signOut();
      return right(unit);
    } catch (e) {
      return left(
        const AuthFailure.signOutFailure(),
      );
    }
  }
}
