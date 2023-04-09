import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wallet/firebase_options.dart';
import 'package:wallet/presentation/blocs/wallet_bloc_observer.dart';
import 'package:wallet/presentation/presentation_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const PresentationMain(),
  );
}
