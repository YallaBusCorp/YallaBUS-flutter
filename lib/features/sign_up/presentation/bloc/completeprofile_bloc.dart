import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/features/home/presentation/bloc/map/map_bloc.dart';
import '../../domain/enitity/student.dart';
import '../../domain/use_case/get_all_universities.dart';
import '../../domain/use_case/get_student_id.dart';
import '../../domain/use_case/post_student_information.dart';

import '../../../../core/injection/di.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../domain/use_case/get_all_towns.dart';

part 'completeprofile_event.dart';
part 'completeprofile_state.dart';

class CompleteprofileBloc
    extends Bloc<CompleteprofileEvent, CompleteprofileState> {
  GetAllUniversities university;
  GetAllTowns town;
  PostStudentInformation postStudent;
  GetStudentId stdId;
  List<String> names = [];
  List<int> ids = [];
  late int companyId;
  late Student student;
  int townId = 0;
  int universityId = 0;
  SharedPreferences perfs = di<SharedPreferences>();

  CompleteprofileBloc(this.university, this.town, this.postStudent, this.stdId)
      : super(CompleteprofileInitial()) {
    on<CompleteprofileEvent>((event, emit) {});

    on<SendTownValueEvent>((event, emit) {
      townId = event.value;

      emit(ChangeTownValue());
    });

    on<SendUniValueEvent>((event, emit) {
      universityId = event.value;

      emit(ChangeTownValue());
    });

    on<GetAllUniversitiesEvent>((event, emit) async {
      (await university
              .getAllUniversities(perfs.getInt(ConstantsManager.company)!))
          .fold((failure) {
        emit(FetchUniError(failure.message));
      }, (r) {
        ids = r.map((e) => e.id).toList();
        names = r.map((e) => e.universityName).toList();
        emit(FetchUniSuccess(names, ids));
      });
    });

    on<GetAllTownsEvent>((event, emit) async {
      (await town.getAllTowns(perfs.getInt(ConstantsManager.company)!)).fold(
          (failure) {
        emit(FetchTownsError(failure.message));
      }, (r) {
        ids = r.map((e) => e.id).toList();
        names = r.map((e) => e.townName).toList();
        emit(FetchTownsSuccess(names, ids));
      });
    });

    on<SendStudentDataEvent>((event, emit) async {
      emit(LoadingSendData());
      student = Student(
          stdUid: perfs.getString(ConstantsManager.uid)!,
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

    on<GetStudentIDEvent>((event, emit) async {
      (await stdId.getStudentId(event.uid)).fold((l) {
        print(l.message);
      }, (r) {
        print(r);
        perfs.setInt(ConstantsManager.stdId, r);
      });
    });
  }
}
