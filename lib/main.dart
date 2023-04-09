import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:wallet/presentation/blocs/wallet_bloc_observer.dart';
import 'package:wallet/presentation/presentation_main.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(
    const PresentationMain(),
  );
}
