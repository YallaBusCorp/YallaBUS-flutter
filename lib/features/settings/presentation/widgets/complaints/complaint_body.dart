import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';
import '../../../../../core/custom_widgets/Decoration_widget.dart';
import '../../../../../core/custom_widgets/text_widget.dart';
import '../../../../../core/injection/di.dart';
import '../../../../../core/resources/routes_manager.dart';
import '../../bloc/settings_bloc.dart';
import 'complaint_response.dart';

class ComplaintBody extends StatefulWidget {
  final int index;
  const ComplaintBody({Key? key, required this.index}) : super(key: key);

  @override
  State<ComplaintBody> createState() => _ComplaintBodyState();
}

class _ComplaintBodyState extends State<ComplaintBody> {
  late SettingsBloc bloc;
  @override
  void initState() {
    bloc = di<SettingsBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SettingsBloc bloc = BlocProvider.of<SettingsBloc>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.complaintMessageAndResponse,
            arguments: widget.index);
      },
      child: DecorationBoxWidget(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        bloc.docData[widget.index]['response'] == null
                            ? ColorsManager.offRed
                            : ColorsManager.green,
                    radius: 10,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(bloc.docData[widget.index]['complaintID'],
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 18)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  StringsExtensions.splitDate(
                      bloc.docData[widget.index]['msgTimestamp'])[0],
                  style: Theme.of(context).textTheme.caption!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
