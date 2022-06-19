part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class SignOutEvent extends SettingsEvent {}

class GetTownsOfCompanyEvent extends SettingsEvent {}

class GetUniversitiesOfCompanyEvent extends SettingsEvent {}

class GetCompanyInfoEvent extends SettingsEvent {
  final int companyId;

  GetCompanyInfoEvent(this.companyId);
}

class SelectFaqQuestionEvent extends SettingsEvent {
  final int index;
  final bool open;

  SelectFaqQuestionEvent(this.index, this.open);
}

class UpdateStudentInfoEvent extends SettingsEvent {
  final Student student;

  UpdateStudentInfoEvent(this.student);
}

