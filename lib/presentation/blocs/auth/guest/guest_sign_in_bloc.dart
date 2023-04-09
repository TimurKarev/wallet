import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'guest_sign_in_event.dart';
part 'guest_sign_in_state.dart';
part 'guest_sign_in_bloc.freezed.dart';

class GuestSignInBloc extends Bloc<GuestSignInEvent, GuestSignInState> {
  GuestSignInBloc() : super(const GuestSignInState.initial()) {
    on<GuestSignInEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
