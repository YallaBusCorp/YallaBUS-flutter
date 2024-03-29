import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/custom_widgets/button_widget.dart';
import '../../../../core/custom_widgets/loading_dialog.dart';
import '../../../../core/custom_widgets/success_dialog.dart';
import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/resources/asset_manager.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../bloc/completeprofile_bloc.dart';
import '../widgets/drop_down_widget.dart';
import '../../../../core/custom_widgets/error_dialog.dart';
import '../../../../core/extensions/extensions.dart';
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
  late CompleteprofileBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<CompleteprofileBloc>(context);
    bloc.add(GetAllUniversitiesEvent());
    bloc.add(GetAllTownsEvent());

    super.initState();
  }

  @override
  void didChangeDependencies() {
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
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (BuildContext context) => const Dialog(
              insetPadding: EdgeInsets.all(25),
              backgroundColor: Colors.transparent,
              child: SuccessDialog(
                message: StringManager.successMessage,
              ),
            ),
          );
          Future.delayed(const Duration(seconds: ValuesManager.iv2), () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.home,
              (route) => false,
            );
            bloc.add(AddStdentUidToFireStoreEvent());
          });
        } else if (state is PostStudentDataError) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (BuildContext context) => Dialog(
              insetPadding: const EdgeInsets.all(25),
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
                    type: true,
                    hint: StringManager.town,
                    options: towns,
                    ids: townsIds);
              }),
              BlocBuilder<CompleteprofileBloc, CompleteprofileState>(
                builder: (context, state) {
                  return DropDownWidget(
                    type: false,
                    hint: StringManager.university,
                    options: universities,
                    ids: universitiesIds,
                  );
                },
              ),
              const Spacer(),
              ButtonWidget(
                onPressed: checkValidation() == true ? _onPressed : null,
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
    String userName = "${firstNameController.text} ${lastNameController.text}";
    bloc.perfs.setString(ConstantsManager.firstName, firstNameController.text);
    bloc.perfs.setString(ConstantsManager.secondName, lastNameController.text);
    bloc.add(SendStudentDataEvent(userName));
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  bool checkValidation() {
    if (firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        bloc.townId != 0 &&
        bloc.universityId != 0) {
      return true;
    }
    return false;
  }
}
