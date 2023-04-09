part of 'guest_sign_in_bloc.dart';

@freezed
class GuestSignInState with _$GuestSignInState {
  const factory GuestSignInState.idle() = _Idle;
  const factory GuestSignInState.loading() = _Loading;
  const factory GuestSignInState.error(AuthFailure failure) = _Error;
}
