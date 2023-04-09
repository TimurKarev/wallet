part of 'guest_sign_in_bloc.dart';

@freezed
class GuestSignInEvent with _$GuestSignInEvent {
  const factory GuestSignInEvent.started() = _Started;
}
