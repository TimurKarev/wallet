import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet/domain/entities/user/app_user.dart';
import 'package:wallet/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
      : _authRepo = authRepository,
        super(const AuthState.unknown()) {
    on<_Started>(_onStarted);
    on<_SignOut>(_onSignOut);

    add(const AuthEvent.started());
  }

  final AuthRepository _authRepo;

  Future<void> _onStarted(
    _Started event,
    Emitter<AuthState> emitter,
  ) async {
    emitter(const AuthState.loading());

    await emitter.forEach(
      _authRepo.getWalletUser(),
      onData: (user) => user.fold(
        () => const AuthState.unknown(),
        (user) => AuthState.success(user),
      ),
    );
  }

  Future<void> _onSignOut(
    _SignOut event,
    Emitter<AuthState> emitter,
  ) async {
    final response = await _authRepo.signOut();

    response.fold(
      (l) => emitter(const AuthState.error('Error')),
      (_) => emitter(const AuthState.unknown()),
    );
  }
}
