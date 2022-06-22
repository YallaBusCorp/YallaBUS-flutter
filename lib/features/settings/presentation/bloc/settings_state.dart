part of 'settings_bloc.dart';

@immutable
abstract class SettingsState extends Equatable {
  const SettingsState();
  @override
  List<Object?> get props => [];
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

class Loading extends SettingsState {}

class UpdateStudentInfoSuccess extends SettingsState {}

class UpdateStudentInfoError extends SettingsState {}

class GetNewComplaintDataSuccess extends SettingsState {
  const GetNewComplaintDataSuccess();
}

class PostComplaintSuccess extends SettingsState {}

class PostComplaintError extends SettingsState {}

class RefershMessage extends SettingsState {
  final String value;

  const RefershMessage(this.value);

  @override
  List<Object?> get props => [value];
}

class GetNotScannedRidesSuccess extends SettingsState {
  final List<RideHis> list;

  const GetNotScannedRidesSuccess(this.list);
}

class GetNonScannedRidesError extends SettingsState {
  final String message;

  const GetNonScannedRidesError(this.message);
}

class GetScannedRidesSuccess extends SettingsState {
  final List<RideHis> list;

  const GetScannedRidesSuccess(this.list);
}

class GetScannedRidesError extends SettingsState {
  final String message;

  const GetScannedRidesError(this.message);
}
