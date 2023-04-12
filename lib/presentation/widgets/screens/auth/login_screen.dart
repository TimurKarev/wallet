import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/presentation/blocs/auth/auth_bloc.dart';
import 'package:wallet/presentation/blocs/auth/guest/sign_in_bloc.dart';
import 'package:wallet/router/paths.dart' as paths;

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (_, state) => state.mapOrNull(
        success: (_) => GoRouter.of(context).go(paths.home),
      ),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: () => context.read<AppleSignInBloc>().add(
                    const SignInEvent.sign(),
                  ),
              child: const Text('apple'),
            ),
            TextButton(
              onPressed: () => context.read<GoogleSignInBloc>().add(
                    const SignInEvent.sign(),
                  ),
              child: const Text('google'),
            ),
            TextButton(
              onPressed: () => context.read<GuestSignInBloc>().add(
                    const SignInEvent.sign(),
                  ),
              child: const Text('guest login'),
            ),
          ],
        ),
      ),
    );
  }
}
