import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';
import 'package:yalla_bus/core/custom_widgets/show_dialog.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/sign_up/presentation/bloc/completeprofile_bloc.dart';
import 'package:yalla_bus/features/sign_up/presentation/widgets/drop_down_widget.dart';

import '../../../../core/extensions/extensions.dart';
import '../../domain/enitity/student.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  //Create bloc to make a call to get a list of university and towns
  List<String> towns = [];
  List<String> universities = [];
  List<int> townsIds = [];
  List<int> universitiesIds = [];
  late Student student;
  @override
  void didChangeDependencies() {
    BlocProvider.of<CompleteprofileBloc>(context)
        .add(GetAllUniversitiesEvent());
    BlocProvider.of<CompleteprofileBloc>(context).add(GetAllTownsEvent());
    townsIds.clear();
    universitiesIds.clear();
    super.didChangeDependencies();
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  FocusNode textSecondFocusNode =  FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompleteprofileBloc, CompleteprofileState>(
      listener: (context, state) async {
        if (state is PostStudentDataSuccess) {
          DialogWidget(context, 'You have  successfully signed up!', 'Success');
          await Future.delayed(const Duration(seconds: 2));

          // .pushNamedAndRemoveUntil(Routes.home, (route) => false);
          Navigator.of(context).pushNamed(Routes.successfulPayment);
        } else if (state is PostStudentDataError) {
          DialogWidget(context, state.message, 'Error');
        } else if (state is LoadingSendData) {
          DialogWidget(context, StringManager.wait, 'Loading');
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: TextWidget(
              text: StringManager.compeletProfile.tr(),
              style: Theme.of(context).textTheme.headline5!),
        ),
        body: Padding(
          padding: const EdgeInsets.all(ValuesManager.v16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetManager.completeProfileIll,
                width: ValuesManager.v250,
                height: ValuesManager.v250,
              ),
              const SizedBox(
                height: ValuesManager.v5,
              ),
              //Edit Widget itself
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 15,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: ValuesManager.v5),
                    child: TextFormField(
                      onFieldSubmitted: (String value) {
                        FocusScope.of(context)
                            .requestFocus(textSecondFocusNode);
                      },
                      style: Theme.of(context).textTheme.headline6,
                      controller: firstNameController,
                      decoration: TextFormStyle.applyDecoration(
                          StringManager.firstName.tr(), Icons.person, context),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 15,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: ValuesManager.v5),
                    child: TextFormField(
                      focusNode: textSecondFocusNode,
                      onFieldSubmitted: (String value) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      style: Theme.of(context).textTheme.headline6,
                      controller: lastNameController,
                      decoration: TextFormStyle.applyDecoration(
                          StringManager.lastName.tr(), Icons.person, context),
                    ),
                  ),
                ),
              ),

              BlocConsumer<CompleteprofileBloc, CompleteprofileState>(
                listener: (context, state) {
                  if (state is FetchTownsSuccess) {
                    townsIds = state.towns.map((e) => e.id).toList();
                    towns = state.towns.map((e) => e.townName).toList();
                  }
                },
                builder: (context, state) {
                  return DropDownWidget(
                      hint: StringManager.town, options: towns, ids: townsIds);
                },
              ),
              BlocConsumer<CompleteprofileBloc, CompleteprofileState>(
                listener: (context, state) {
                  if (state is FetchUniSuccess) {
                    universitiesIds =
                        state.universities.map((e) => e.id).toList();
                    universities = state.universities
                        .map((e) => e.universityName)
                        .toList();
                  }
                },
                builder: (context, state) {
                  return DropDownWidget(
                    hint: StringManager.university,
                    options: universities,
                    ids: universitiesIds,
                  );
                },
              ),

              const Spacer(),
              ButtonWidget(
                onPressed: _onPressed,
                child: Text(StringManager.continueToPayment.tr(),
                    style: Theme.of(context).textTheme.headline6!),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressed() {
    String userName =
        "${firstNameController.text} ${lastNameController.text}";

    BlocProvider.of<CompleteprofileBloc>(context)
        .add(SendStudentDataEvent(userName));
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }
}
