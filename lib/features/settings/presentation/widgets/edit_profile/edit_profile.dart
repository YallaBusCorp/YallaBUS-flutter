import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/custom_widgets/Decoration_widget.dart';
import '../../../../../core/custom_widgets/button_widget.dart';
import '../../../../../core/custom_widgets/error_dialog.dart';
import '../../../../../core/custom_widgets/loading_dialog.dart';
import '../../../../../core/custom_widgets/separtor_widget.dart';
import '../../../../../core/custom_widgets/success_dialog.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/injection/di.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/colors_manager.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../../../core/resources/routes_manager.dart';
import '../../../../sign_up/domain/enitity/student.dart';
import '../../../../sign_up/presentation/widgets/drop_down_widget.dart';
import '../../bloc/settings_bloc.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  late SettingsBloc bloc;

  @override
  void initState() {
    bloc = di<SettingsBloc>();
    bloc.add(GetTownsOfCompanyEvent());
    bloc.add(GetUniversitiesOfCompanyEvent());
    firstNameController.text =
        bloc.perfs.getString(ConstantsManager.firstName)!;
    lastNameController.text =
        bloc.perfs.getString(ConstantsManager.secondName)!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:
            Text('Edit Profile', style: Theme.of(context).textTheme.headline5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocListener<SettingsBloc, SettingsState>(
          listener: (context, state) {
            if (state is Loading) {
              showDialog(
                context: context,
                builder: (BuildContext context) => const Dialog(
                  backgroundColor: Colors.transparent,
                  child: LoadingDialog(),
                ),
              );
            }
            if (state is UpdateStudentInfoSuccess) {
              showDialog(
                context: context,
                builder: (BuildContext context) => const Dialog(
                  backgroundColor: Colors.transparent,
                  child: SuccessDialog(
                    message: 'You have updated your account !',
                  ),
                ),
              );
            }

            if (state is UpdateStudentInfoError) {
              showDialog(
                context: context,
                builder: (BuildContext context) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: ErrorDialog(
                    message: 'Server Error',
                    onTap: () {},
                  ),
                ),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: firstNameController,
                decoration: TextFormStyle.applyDecoration(
                    firstNameController.text, Icons.person, context),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: lastNameController,
                decoration: TextFormStyle.applyDecoration(
                    lastNameController.text, Icons.person, context),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  return DropDownWidget(
                      type: true,
                      hint: bloc.perfs.getString(ConstantsManager.townName)!,
                      ids: bloc.towns.values.toList(),
                      options: bloc.towns.keys.toList());
                },
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  return DropDownWidget(
                      type: false,
                      hint: bloc.perfs
                          .getString(ConstantsManager.universityName)!,
                      ids: bloc.universities.values.toList(),
                      options: bloc.universities.keys.toList());
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DecorationBoxWidget(
                radius: BorderRadius.circular(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(Routes.loginOtp, arguments: 'Edit');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Change Phone Number',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontSize: 18),
                            ),
                            SvgPicture.asset(
                              AssetManager.arrow,
                              width: 10,
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Separtor(
                      color: [
                        Colors.grey.shade800,
                        Colors.grey.shade800,
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(Routes.chooseCompany, arguments: 'Edit');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Switch Company',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontSize: 18),
                            ),
                            SvgPicture.asset(
                              AssetManager.arrow,
                              width: 10,
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Separtor(
                      color: [
                        Colors.grey.shade800,
                        Colors.grey.shade800,
                      ],
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delete Account',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontSize: 18,
                                      color: ColorsManager.offRed),
                            ),
                            Icon(
                              Icons.delete,
                              size: 20,
                              color: ColorsManager.offRed,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: ButtonWidget(
                  onPressed: () {
                    bloc.add(
                      UpdateStudentInfoEvent(
                        Student(
                          stdUid: bloc.perfs.getString(ConstantsManager.uid)!,
                          stdName: firstNameController.text +
                              ' ' +
                              lastNameController.text,
                          stdPhone:
                              bloc.perfs.getString(ConstantsManager.number)!,
                          companyId: CompanyId(
                              bloc.perfs.getInt(ConstantsManager.company)!),
                          townId: TownId(2),
                          universityId: UniversityId(4),
                        ),
                      ),
                    );
                  },
                  child: Text('Save',
                      style: Theme.of(context).textTheme.headline6!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
