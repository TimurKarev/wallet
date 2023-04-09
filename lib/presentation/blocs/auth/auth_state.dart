part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.loading() = _Loading;
  const factory AuthState.unknown() = _Unknown;
  const factory AuthState.success(AppUser user) = _Success;
  const factory AuthState.error(String message) = _Error;
// Add other state constructors here
}
