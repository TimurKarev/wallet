part of 'sign_in_bloc.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.idle() = _Idle;
  const factory SignInState.loading() = _Loading;
  const factory SignInState.error(AuthFailure failure) = _Error;
}
