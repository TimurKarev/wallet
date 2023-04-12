import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet/domain/entities/user/app_user.dart';
import 'package:wallet/domain/repositories/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with ChangeNotifier {
  AuthBloc({required AuthRepository authRepository})
      : _authRepo = authRepository,
        super(const AuthState.loading()) {
    on<_EmptyUser>((event, emitter) {
      emitter(const AuthState.unknown());
      notifyListeners();
    });
    on<_User>((event, emitter) {
      emitter(AuthState.success(event.user));
      notifyListeners();
    });
    on<_SignOut>(_onSignOut);

    authRepository.getWalletUser().listen((event) {
      event.fold(
        () => add(const AuthEvent.emptyUser()),
        (user) => add(
          AuthEvent.user(user),
        ),
      );
    });
  }

  final AuthRepository _authRepo;

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
