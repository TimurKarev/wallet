import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallet/domain/entities/failures/auth_failure.dart';
import 'package:wallet/domain/entities/user/app_user.dart';
import 'package:wallet/domain/repositories/auth/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth;

  FirebaseAuthRepository({required FirebaseAuth auth}) : _auth = auth;

  @override
  Stream<Option<AppUser>> getWalletUser() {
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
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      return const Right(unit); // Return success (Right)
    } on FirebaseAuthException {
      // Handle FirebaseAuthException
      return const Left(AuthFailure
          .signInFailure()); // Return failure with error message (Left)
    } catch (e) {
      // Handle other exceptions
      return const Left(
        AuthFailure.signInFailure(),
      ); // Return failure with generic error message (Left)
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithApple() async {
    try {
      final appleProvider = AppleAuthProvider();
      if (kIsWeb) {
        await FirebaseAuth.instance.signInWithPopup(appleProvider);
      } else {
        await FirebaseAuth.instance.signInWithProvider(appleProvider);
      }
      return const Right(unit); // Return success (Right)
    } on FirebaseAuthException catch (_) {
      // Handle FirebaseAuthException
      return const Left(
        AuthFailure.signInFailure(),
      );
    } catch (_) {
      // Handle other exceptions
      return const Left(
        AuthFailure.signInFailure(),
      );
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
