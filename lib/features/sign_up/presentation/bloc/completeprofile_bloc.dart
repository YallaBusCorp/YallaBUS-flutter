import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yalla_bus/features/choose_company/presentation/bloc/company_selection_bloc.dart';
import 'package:yalla_bus/features/sign_up/domain/enitity/university.dart';
import 'package:yalla_bus/features/sign_up/domain/use_case/get_all_universities.dart';

import '../../domain/enitity/town.dart';
import '../../domain/use_case/get_all_towns.dart';

part 'completeprofile_event.dart';
part 'completeprofile_state.dart';

class CompleteprofileBloc
    extends Bloc<CompleteprofileEvent, CompleteprofileState> {
  GetAllUniversities university;
  GetAllTowns town;
  List<University> allUniversities = [];
  List<Town> allTowns = [];
  late int companyId;
  late StreamSubscription companyStream;
  final CompanySelectionBloc companyBloc;

  @override
  void onChange(Change<CompleteprofileState> change) {
    super.onChange(change);
    print(change);
  }

  CompleteprofileBloc(this.university, this.town, this.companyBloc)
      : super(CompleteprofileInitial()) {
    companyStream = companyBloc.stream.listen((state) {
      if (state is Confirmation) {
        companyId = state.id;
      }
    });
    on<CompleteprofileEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetAllUniversitiesEvent>((event, emit) async {
      (await university.getAllUniversities(1)).fold((failure) {
        emit(FetchUniError(failure.message));
      }, (r) {
        allUniversities = r;
        emit(FetchUniSuccess(r));
      });
    });

    on<GetAllTownsEvent>((event, emit) async {
      (await town.getAllTowns(1)).fold((failure) {
        emit(FetchTownsError(failure.message));
      }, (r) {
        allTowns = r;
        emit(FetchTownsSuccess(r));
      });
    });
  }
}
