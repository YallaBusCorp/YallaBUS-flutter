part of 'settings_bloc.dart';

@immutable
abstract class SettingsState extends Equatable {
  const SettingsState();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SettingsInitial extends SettingsState {}

class SignOutSuccess extends SettingsState {}

class SignOutError extends SettingsState {
  final String message;

  const SignOutError(this.message);
}
