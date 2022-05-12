import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/core/custom_widgets/error_dialog.dart';
import 'package:yalla_bus/core/custom_widgets/loading_dialog.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/features/choose_company/presentation/widgets/company_information.dart';
import 'package:yalla_bus/features/settings/presentation/bloc/settings_bloc.dart';

import '../../../../../core/injection/di.dart';
import '../../../../choose_company/domain/enitity/company.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  late SettingsBloc bloc;
  @override
  void initState() {
    bloc = di<SettingsBloc>();
    BlocProvider.of<SettingsBloc>(context)
        .add(GetCompanyInfoEvent(bloc.perfs.getInt(ConstantsManager.company)!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is GetCompanyError) {
          showDialog(
            context: context,
            builder: (_) => Dialog(
                insetPadding: const EdgeInsets.all(25),
                backgroundColor: Colors.transparent,
                child: ErrorDialog(message: state.message, onTap: () {})),
          );
        } else {
          showDialog(
            context: context,
            builder: (_) => const Dialog(
              insetPadding: EdgeInsets.all(25),
              backgroundColor: Colors.transparent,
              child: LoadingDialog(),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is GetCompanySuccess) {
          return CompanyInfo(company: state.company);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
