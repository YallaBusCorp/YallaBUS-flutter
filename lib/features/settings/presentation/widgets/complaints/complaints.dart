import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yalla_bus/core/custom_widgets/loading_dialog.dart';
import '../../../../../core/injection/di.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../../../core/resources/routes_manager.dart';
import '../../bloc/settings_bloc.dart';
import 'complaint_body.dart';

import '../../../../../core/resources/colors_manager.dart';

class Complaints extends StatefulWidget {
  const Complaints({Key? key}) : super(key: key);

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  late SettingsBloc bloc;
  late Stream<QuerySnapshot> complaintStream;
  @override
  void initState() {
    bloc = BlocProvider.of<SettingsBloc>(context);
    complaintStream = FirebaseFirestore.instance
        .collection('company')
        .doc(bloc.perfs.getString(ConstantsManager.companyName))
        .collection('complaint')
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complaints',
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.fileComplaint);
            },
            icon: const Icon(Icons.add),
            iconSize: 30,
            color: ColorsManager.orange,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<QuerySnapshot>(
            stream: complaintStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                bloc.add(GetNewComplaintDataEvent(snapshot.data!.docs));
              }
              return BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  return bloc.docData.isNotEmpty
                      ? ListView.separated(
                          itemCount: bloc.docData.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return ComplaintBody(index: index);
                          },
                        )
                      : Center(
                          child: SvgPicture.asset(
                            AssetManager.error404,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        );
                },
              );
            }),
      ),
    );
  }
}
