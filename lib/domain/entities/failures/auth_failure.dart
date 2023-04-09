import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const factory AuthFailure.signInFailure() = _SignIn;
  const factory AuthFailure.signOutFailure() = _SignOut;
// TODO: Add more failure cases as needed
}
