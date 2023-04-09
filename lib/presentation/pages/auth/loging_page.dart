import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/data/repositories/firebase/firebase_auth_repository.dart';
import 'package:wallet/presentation/blocs/auth/guest/guest_sign_in_bloc.dart';
import 'package:wallet/presentation/widgets/screens/auth/login_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GuestSignInBloc(
        // TODO: add get it
        authRepository: FirebaseAuthRepository(
          auth: FirebaseAuth.instance,
        ),
      ),
      child: const LoginScreen(),
    );
  }
}
