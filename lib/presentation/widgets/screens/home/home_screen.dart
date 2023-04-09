import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/presentation/blocs/auth/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () => context.read<AuthBloc>().add(
                const AuthEvent.signOut(),
              ),
          child: const Text('LOGOUT'),
        ),
      ),
    );
  }
}
