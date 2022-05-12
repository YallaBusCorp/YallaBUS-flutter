import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/injection/di.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../../choose_company/domain/enitity/company.dart';
import '../../../sign_up/domain/use_case/get_all_towns.dart';
import '../../../sign_up/domain/use_case/get_all_universities.dart';
import '../../../sign_up/presentation/bloc/completeprofile_bloc.dart';
import '../../domain/use_case/get_company_info.dart';

part 'settings_event.dart';
part 'settings_state.dart';

enum Resonses { answered, inQueue }

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  Color replyOrNot = Colors.red;
  List<String> dropDownOptions = [
    'Driver issues',
    'Subscription issues',
    'Other',
  ];
  GetAllUniversities university;
  GetAllTowns town;
  GetCompanyInfo company;
  late Company companyItem;
  List<String> names = [];
  List<int> ids = [];
  SharedPreferences perfs = di<SharedPreferences>();
  SettingsBloc(this.town, this.university, this.company)
      : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) {
      // TODO: implement event handler
    });

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
        ids = r.map((e) => e.id).toList();
        names = r.map((e) => e.townName).toList();
        emit(GetTownsSuccess(names, ids));
      });
    });

    on<GetUniversitiesOfCompanyEvent>((event, emit) async {
      (await university
              .getAllUniversities(perfs.getInt(ConstantsManager.company)!))
          .fold((failure) {
        emit(FetchUniError(failure.message));
      }, (r) {
        ids = r.map((e) => e.id).toList();
        names = r.map((e) => e.universityName).toList();
        emit(GetUniversitiesSuccess(names, ids));
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
  }
}
