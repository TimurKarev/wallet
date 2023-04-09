import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet/domain/entities/failures/auth_failure.dart';
import 'package:wallet/domain/repositories/auth_repository.dart';

part 'guest_sign_in_event.dart';
part 'guest_sign_in_state.dart';
part 'guest_sign_in_bloc.freezed.dart';

class GuestSignInBloc extends Bloc<GuestSignInEvent, GuestSignInState> {
  GuestSignInBloc({required this.authRepository})
      : super(const GuestSignInState.idle()) {
    on<_Sign>(_onSignIn);
  }

  final AuthRepository authRepository;

  void _onSignIn(
    _Sign event,
    Emitter<GuestSignInState> emit,
  ) async {
    emit(const GuestSignInState.loading());

    final result = await authRepository.signInAnonymously();

    // Check the result of sign in attempt
    result.fold(
      (failure) => emit(GuestSignInState.error(failure)),
      (unit) => emit(const GuestSignInState.idle()),
    );
  }
}
