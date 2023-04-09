import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/presentation/blocs/auth/auth_bloc.dart';
import 'package:wallet/data/repositories/firebase/firebase_auth_repository.dart';
import 'package:wallet/router/router_config.dart';

class PresentationMain extends StatelessWidget {
  const PresentationMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            authRepository: FirebaseAuthRepository(
              auth: FirebaseAuth.instance,
            ),
          ),
        ),
      ],
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig(
        context.read<AuthBloc>(),
      ),
      title: 'Wallet',
    );
  }
}
