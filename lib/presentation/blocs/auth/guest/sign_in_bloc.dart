import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet/domain/entities/failures/auth_failure.dart';
import 'package:wallet/domain/use_cases/auth/sign_in_use_case.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';
part 'sign_in_bloc.freezed.dart';

typedef SignInBlocType = Bloc<SignInEvent, SignInState>;

mixin GuestSignInBloc on SignInBlocType {}
mixin GoogleSignInBloc on SignInBlocType {}
mixin AppleSignInBloc on SignInBlocType {}

class SignInBloc extends SignInBlocType
    with GuestSignInBloc, GoogleSignInBloc, AppleSignInBloc {
  SignInBloc({required SignInUseCase signInUseCase})
      : _signIn = signInUseCase,
        super(const SignInState.idle()) {
    on<_Sign>(_onSignIn);
  }

  final SignInUseCase _signIn;

  void _onSignIn(
    _Sign event,
    Emitter<SignInState> emit,
  ) async {
    emit(const SignInState.loading());

    final result = await _signIn.signIn();

    // Check the result of sign in attempt
    result.fold(
      (failure) => emit(SignInState.error(failure)),
      (unit) => emit(const SignInState.idle()),
    );
  }
}
