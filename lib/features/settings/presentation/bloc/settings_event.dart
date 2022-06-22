part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

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

class GetNewComplaintDataEvent extends SettingsEvent {
  final List<QueryDocumentSnapshot<Object?>> snapshot;
  @override
  List<Object> get props => [snapshot];
  GetNewComplaintDataEvent(this.snapshot);
}

class SnapShotLoadingEvent extends SettingsEvent {}

class PostComplaintEvent extends SettingsEvent {
  final String text;

  PostComplaintEvent(this.text);
}

class RefershMessageEvent extends SettingsEvent {
  final String value;

  RefershMessageEvent(this.value);
}

class GetNotScannedRidesEvent extends SettingsEvent {
  final int id;

  GetNotScannedRidesEvent(this.id);
}

class GetScannedRidesEvent extends SettingsEvent {
  final int id;

  GetScannedRidesEvent(this.id);
}
