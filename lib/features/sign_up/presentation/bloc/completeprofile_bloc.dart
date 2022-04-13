import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/features/choose_company/presentation/bloc/company_selection_bloc.dart';
import 'package:yalla_bus/features/sign_up/domain/enitity/student.dart';
import 'package:yalla_bus/features/sign_up/domain/enitity/university.dart';
import 'package:yalla_bus/features/sign_up/domain/use_case/get_all_universities.dart';
import 'package:yalla_bus/features/sign_up/domain/use_case/post_student_information.dart';

import '../../../../core/injection/di.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../domain/enitity/town.dart';
import '../../domain/use_case/get_all_towns.dart';

part 'completeprofile_event.dart';
part 'completeprofile_state.dart';

class CompleteprofileBloc
    extends Bloc<CompleteprofileEvent, CompleteprofileState> {
  GetAllUniversities university;
  GetAllTowns town;
  PostStudentInformation postStudent;
  List<University> allUniversities = [];
  List<Town> allTowns = [];
  late int companyId;
  late Student student;
  late int townId;
  late int universityId;
  SharedPreferences perfs = di<SharedPreferences>();

  @override
  void onChange(Change<CompleteprofileState> change) {
    super.onChange(change);
    print(change);
  }

  CompleteprofileBloc(this.university, this.town, this.postStudent)
      : super(CompleteprofileInitial()) {
    on<CompleteprofileEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SendTownValueEvent>((event, emit) {
      townId = event.value;
      emit(ChangeTownValue());
    });

    on<SendUniValueEvent>((event, emit) {
      universityId = event.value;
      emit(ChangeTownValue());
    });

    on<GetAllUniversitiesEvent>((event, emit) async {
      (await university.getAllUniversities(perfs.getInt(ConstantsManager.company)!)).fold((failure) {
        emit(FetchUniError(failure.message));
      }, (r) {
        allUniversities = r;
        emit(FetchUniSuccess(r));
      });
    });

    on<GetAllTownsEvent>((event, emit) async {
      (await town.getAllTowns(perfs.getInt(ConstantsManager.company)!)).fold((failure) {
        emit(FetchTownsError(failure.message));
      }, (r) {
        allTowns = r;
        emit(FetchTownsSuccess(r));
      });
    });

    on<SendStudentDataEvent>((event, emit) async {
      student = Student(
          code: perfs.getString(ConstantsManager.uid)!,
          stdName: event.userName,
          stdPhone: perfs.getString(ConstantsManager.number)!,
          companyId: CompanyId(perfs.getInt(ConstantsManager.company)!),
          townId: TownId(townId),
          universityId: UniversityId(universityId));
      (await postStudent.postStudentInfo(student)).fold((failure) {
        emit(PostStudentDataError(failure.message));
      }, (r) {
        emit(PostStudentDataSuccess());
      });
    });
  }
}
