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

class GetTownsSuccess extends SettingsState {
  const GetTownsSuccess();
}

class GetUniversitiesSuccess extends SettingsState {
  const GetUniversitiesSuccess();
}

class FetchTownsError extends SettingsState {
  final String name;

  const FetchTownsError(this.name);
}

class FetchUniError extends SettingsState {
  final String name;

  const FetchUniError(this.name);
}

class GetCompanySuccess extends SettingsState {
  final Company company;

  const GetCompanySuccess(this.company);
}

class GetCompanyError extends SettingsState {
  final String message;

  GetCompanyError(this.message);
}

class FAQsChange extends SettingsState {}

class Loading extends SettingsState{}

class UpdateStudentInfoSuccess extends SettingsState {}

class UpdateStudentInfoError extends SettingsState {}
