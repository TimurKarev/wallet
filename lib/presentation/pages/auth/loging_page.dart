import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/data/repositories/firebase/firebase_auth_repository.dart';
import 'package:wallet/data/use_cases/firebase/auth/firebase_apple_sign_in_use_case.dart';
import 'package:wallet/data/use_cases/firebase/auth/firebase_google_sign_in_use_case.dart';
import 'package:wallet/data/use_cases/firebase/auth/firebase_guest_sign_in_use_case.dart';
import 'package:wallet/presentation/blocs/auth/guest/sign_in_bloc.dart';
import 'package:wallet/presentation/widgets/screens/auth/login_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GuestSignInBloc>(
          // TODO: add get it
          create: (_) => SignInBloc(
            signInUseCase: FirebaseGuestSignInUseCase(
              FirebaseAuthRepository(
                auth: FirebaseAuth.instance,
              ),
            ),
          ),
        ),
        BlocProvider<GoogleSignInBloc>(
          // TODO: add get it
          create: (_) => SignInBloc(
            signInUseCase: FirebaseGoogleSignInUseCase(
              FirebaseAuthRepository(
                auth: FirebaseAuth.instance,
              ),
            ),
          ),
        ),
        BlocProvider<AppleSignInBloc>(
          // TODO: add get it
          create: (_) => SignInBloc(
            signInUseCase: FirebaseAppleSignInUseCase(
              FirebaseAuthRepository(
                auth: FirebaseAuth.instance,
              ),
            ),
          ),
        ),
      ],
      child: const LoginScreen(),
    );
  }
}
