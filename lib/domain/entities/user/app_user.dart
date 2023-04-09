import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String id;
  final String email;

  const AppUser({
    required this.id,
    required this.email,
  });

  factory AppUser.empty() {
    return const AppUser(
      id: '',
      email: '',
    );
  }

  bool get isEmpty => id.isEmpty && email.isEmpty;

  @override
  List<Object?> get props => [
        id,
        email,
      ];
}
