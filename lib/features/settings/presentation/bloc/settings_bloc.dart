import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entity/ride_history_model.dart';
import '../../domain/use_case/get_non_scanned_rides.dart';
import '../../domain/use_case/update_student.dart';
import '../../../sign_up/domain/enitity/student.dart';

import '../../../../core/injection/di.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../../choose_company/domain/enitity/company.dart';
import '../../../choose_company/presentation/bloc/company_selection_bloc.dart';
import '../../../sign_up/domain/use_case/get_all_towns.dart';
import '../../../sign_up/domain/use_case/get_all_universities.dart';
import '../../../sign_up/presentation/bloc/completeprofile_bloc.dart';
import '../../domain/use_case/get_company_info.dart';
import '../../domain/use_case/get_scanned_rides.dart';

part 'settings_event.dart';
part 'settings_state.dart';

enum Resonses { answered, inQueue }

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  Color replyOrNot = Colors.red;
  List<bool> isOpen = [false, false, false, false];
  SharedPreferences perfs = di<SharedPreferences>();
  List<dynamic> docData = [];
  

  @override
  void onChange(Change<SettingsState> change) {
    super.onChange(change);
    print(change.nextState);
  }

  CompanySelectionBloc companyName = di<CompanySelectionBloc>();
  GetAllUniversities university;
  GetAllTowns town;
  GetCompanyInfo company;
  UpdateStudentInfo updateStudentInfo;
  GetNonScannedRides nonScannedRides;
  GetScannedRides scannedRides;
  late Company companyItem;
  String value = "";
  List<String> names = [];
  List<int> ids = [];
  List<RideHis> nonScannedList = [];
  List<RideHis> scannedList = [];
  Map<String, int> towns = {};
  Map<String, int> universities = {};
  SettingsBloc(this.town, this.university, this.company, this.updateStudentInfo,
      this.nonScannedRides, this.scannedRides)
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

    on<GetNewComplaintDataEvent>((event, emit) {
      docData.clear();
      event.snapshot
          .map((DocumentSnapshot document) {
            Map<String, dynamic> s = document.data() as Map<String, dynamic>;
            if (s['userID'] == perfs.getString(ConstantsManager.uid)) {
              docData.add(s);
            }
          })
          .toList()
          .cast();

      emit(const GetNewComplaintDataSuccess());
    });

    on<RefershMessageEvent>((event, emit) {
      value = event.value;
      emit(RefershMessage(value));
    });

    on<PostComplaintEvent>((event, emit) async {
      final data = <String, dynamic>{
        'complaintID': '',
        'message': event.text,
        'msgTimestamp': Timestamp.fromDate(DateTime.now()),
        'rideID': 'ididid',
        'userID': perfs.getString(ConstantsManager.uid),
      };
      DocumentReference value = await FirebaseFirestore.instance
          .collection('company')
          .doc(perfs.getString(ConstantsManager.companyName))
          .collection('complaint')
          .add(data);
      FirebaseFirestore.instance
          .collection('company')
          .doc(perfs.getString(ConstantsManager.companyName))
          .collection('complaint')
          .doc(value.id)
          .update({
        'complaintID': value.id,
      });
      emit(PostComplaintSuccess());
    });

    on<GetNotScannedRidesEvent>((event, emit) async {
      emit(Loading());
      (await nonScannedRides.getNonScannedRides(event.id)).fold((l) {
        l.map((e) {
          if (e.txRide!.rideStatus != 'pending') {
            nonScannedList.add(e);
          }
        });
        emit(GetNotScannedRidesSuccess(nonScannedList));
      }, (r) {
        emit(GetNonScannedRidesError(r.message));
      });
    });

    on<GetScannedRidesEvent>((event, emit) async {
      emit(Loading());
      (await scannedRides.getScannedRides(event.id)).fold((l) {
        emit(GetScannedRidesSuccess(l));
      }, (r) {
        emit(GetScannedRidesError(r.message));
      });
    });
  }
}
