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
