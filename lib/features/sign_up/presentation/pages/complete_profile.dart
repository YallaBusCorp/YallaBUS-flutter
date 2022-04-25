import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';
import 'package:yalla_bus/core/custom_widgets/loading_dialog.dart';
import 'package:yalla_bus/core/custom_widgets/success_dialog.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/sign_up/presentation/bloc/completeprofile_bloc.dart';
import 'package:yalla_bus/features/sign_up/presentation/widgets/drop_down_widget.dart';
import '../../../../core/custom_widgets/error_dialog.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/injection/di.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../domain/enitity/student.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
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
    super.didChangeDependencies();
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  FocusNode textSecondFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompleteprofileBloc, CompleteprofileState>(
      listener: (context, state) async {
        if (state is PostStudentDataSuccess) {
          showDialog(
            context: context,
            builder: (BuildContext context) => const Dialog(
              backgroundColor: Colors.transparent,
              child: SuccessDialog(
                message: StringManager.successMessage,
              ),
            ),
          );
          await Future.delayed(const Duration(seconds: ValuesManager.iv2));
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.successfulPayment,
            (route) => false,
          );
        } else if (state is PostStudentDataError) {
          showDialog(
            context: context,
            builder: (BuildContext context) => Dialog(
              backgroundColor: Colors.transparent,
              child: ErrorDialog(
                message: state.message,
                onTap: _onPressed,
              ),
            ),
          );
        } else if (state is LoadingSendData) {
          showDialog(
            context: context,
            builder: (BuildContext context) => const Dialog(
              backgroundColor: Colors.transparent,
              child: LoadingDialog(),
            ),
          );
        } else if (state is FetchTownsSuccess) {
          towns = state.towns;
          townsIds = state.townsId;
        } else if (state is FetchUniSuccess) {
          universities = state.universities;
          universitiesIds = state.universitiesId;
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
                height: MediaQuery.of(context).size.height / ValuesManager.v15,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: ValuesManager.v5),
                    child: TextFormField(
                      onFieldSubmitted: (String value) {
                        FocusScope.of(context)
                            .requestFocus(textSecondFocusNode);
                      },
                      style: Theme.of(context).textTheme.headline6,
                      cursorColor: ColorsManager.orange,
                      controller: firstNameController,
                      decoration: TextFormStyle.applyDecoration(
                          StringManager.firstName.tr(), Icons.person, context),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / ValuesManager.v15,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: ValuesManager.v5),
                    child: TextFormField(
                      focusNode: textSecondFocusNode,
                      cursorColor: ColorsManager.orange,
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
              BlocBuilder<CompleteprofileBloc, CompleteprofileState>(
                  builder: (context, state) {
                return DropDownWidget(
                    hint: StringManager.town, options: towns, ids: townsIds);
              }),
              BlocBuilder<CompleteprofileBloc, CompleteprofileState>(
                  builder: (context, state) {
                return DropDownWidget(
                  hint: StringManager.university,
                  options: universities,
                  ids: universitiesIds,
                );
              }),

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
    SharedPreferences perfs = di<SharedPreferences>();
    String userName = "${firstNameController.text} ${lastNameController.text}";
    perfs.setString(ConstantsManager.name, userName);
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
