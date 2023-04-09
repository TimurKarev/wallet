part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.emptyUser() = _EmptyUser;
  const factory AuthEvent.user(AppUser user) = _User;
  const factory AuthEvent.signOut() = _SignOut;
}
