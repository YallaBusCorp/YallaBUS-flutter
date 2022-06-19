import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/Login/login_bloc.dart';
import 'package:yalla_bus/features/settings/domain/use_case/update_student.dart';
import 'package:yalla_bus/features/sign_up/domain/enitity/student.dart';

import '../../../../core/injection/di.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../../choose_company/domain/enitity/company.dart';
import '../../../choose_company/presentation/bloc/company_selection_bloc.dart';
import '../../../sign_up/domain/use_case/get_all_towns.dart';
import '../../../sign_up/domain/use_case/get_all_universities.dart';
import '../../../sign_up/presentation/bloc/completeprofile_bloc.dart';
import '../../domain/use_case/get_company_info.dart';

part 'settings_event.dart';
part 'settings_state.dart';

enum Resonses { answered, inQueue }

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  Color replyOrNot = Colors.red;
  List<bool> isOpen = [false, false, false, false];
  List<String> dropDownOptions = [
    'Driver issues',
    'Subscription issues',
    'Other',
  ];

  CompanySelectionBloc companyName = di<CompanySelectionBloc>();
  LoginBloc number = di<LoginBloc>();
  GetAllUniversities university;
  GetAllTowns town;
  GetCompanyInfo company;
  UpdateStudentInfo updateStudentInfo;
  late Company companyItem;
  List<String> names = [];
  List<int> ids = [];
  Map<String, int> towns = {};
  Map<String, int> universities = {};
  SharedPreferences perfs = di<SharedPreferences>();
  SettingsBloc(this.town, this.university, this.company, this.updateStudentInfo)
      : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) {});

    on<SignOutEvent>((event, emit) async {
      try {
        await FirebaseAuth.instance.signOut();
        emit(SignOutSuccess());
      } on FirebaseAuthException catch (e) {
        emit(SignOutError(e.message!));
      }
    });

    on<GetTownsOfCompanyEvent>((event, emit) async {
      (await town.getAllTowns(perfs.getInt(ConstantsManager.company)!)).fold(
          (failure) {
        emit(FetchTownsError(failure.message));
      }, (r) {
        for (var e in r) {
          towns.addEntries([
            MapEntry(e.townName, e.id),
          ]);
        }
        emit(const GetTownsSuccess());
      });
    });

    on<GetUniversitiesOfCompanyEvent>((event, emit) async {
      (await university
              .getAllUniversities(perfs.getInt(ConstantsManager.company)!))
          .fold((failure) {
        emit(FetchUniError(failure.message));
      }, (r) {
        for (var e in r) {
          universities.addEntries([
            MapEntry(e.universityName, e.id),
          ]);
        }
        emit(const GetUniversitiesSuccess());
      });
    });

    on<GetCompanyInfoEvent>((event, emit) async {
      (await company.getCompanyInfo(event.companyId)).fold((l) {
        companyItem = l;
        emit(GetCompanySuccess(l));
      }, (r) {
        emit(GetCompanyError(r.message));
      });
    });

    on<SelectFaqQuestionEvent>((event, emit) {
      isOpen[event.index] = !(event.open);
      emit(FAQsChange());
    });

    on<UpdateStudentInfoEvent>((event, emit) async {
    
      (await updateStudentInfo.update(event.student)).fold((l) {
        final names = event.student.stdName.split(' ');
        perfs.setString(ConstantsManager.firstName, names[0]);
        perfs.setString(ConstantsManager.secondName, names[1]);
        perfs.setInt(ConstantsManager.company, companyName.companyId);
        perfs.setString(ConstantsManager.number, event.student.stdPhone);
        emit(UpdateStudentInfoSuccess());
      }, (r) {
        emit(UpdateStudentInfoError());
      });
    });
  }
}
