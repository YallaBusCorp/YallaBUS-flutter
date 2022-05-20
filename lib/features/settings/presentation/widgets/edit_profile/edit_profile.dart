import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/custom_widgets/Decoration_widget.dart';
import '../../../../../core/custom_widgets/button_widget.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/colors_manager.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../../../core/resources/routes_manager.dart';
import '../../bloc/settings_bloc.dart';
import '../drop_down_widget.dart';
import '../../../../sign_up/presentation/widgets/drop_down_widget.dart';

import '../../../../../core/custom_widgets/separtor_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  late SettingsBloc bloc;
  List<String> towns = [];
  List<String> universities = [];
  List<int> townsIds = [];
  List<int> universitiesIds = [];
  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<SettingsBloc>(context);
    bloc.add(GetTownsOfCompanyEvent());
    bloc.add(GetUniversitiesOfCompanyEvent());
    super.didChangeDependencies();
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
            if (state is GetTownsSuccess) {
              towns = state.name;
              townsIds = state.id;
            } else if (state is GetUniversitiesSuccess) {
              universities = state.name;
              universitiesIds = state.id;
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: firstNameController,
                decoration: TextFormStyle.applyDecoration(
                    bloc.perfs.getString(ConstantsManager.name)!,
                    Icons.person,
                    context),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: secondNameController,
                decoration: TextFormStyle.applyDecoration(
                    bloc.perfs.getString(ConstantsManager.name)!,
                    Icons.person,
                    context),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  return DropDownWidget(
                      type: true,
                      hint: bloc.perfs.getString(ConstantsManager.townName)!,
                      options: towns,
                      ids: townsIds);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DropDownWidget(
                  type: false,
                  hint: bloc.perfs.getString(ConstantsManager.universityName)!,
                  options: universities,
                  ids: universitiesIds),
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
                        Navigator.of(context).pushNamed(Routes.loginOtp);
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
                        Navigator.of(context).pushNamed(Routes.chooseCompany);
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
                  onPressed: () {},
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
