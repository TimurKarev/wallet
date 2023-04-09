import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/presentation/blocs/auth/auth_bloc.dart';
import 'package:wallet/router/paths.dart' as paths;

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (_, state) => state.mapOrNull(
        unknown: (_) => GoRouter.of(context).go(paths.login),
        success: (_) => GoRouter.of(context).go(paths.home),
      ),
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
