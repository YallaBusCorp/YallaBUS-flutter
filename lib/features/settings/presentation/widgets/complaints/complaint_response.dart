import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/features/settings/presentation/bloc/settings_bloc.dart';
import '../../../../../core/custom_widgets/Decoration_widget.dart';
import '../../../../../core/extensions/extensions.dart';

class ComplaintResponse extends StatefulWidget {
  final int index;
  const ComplaintResponse({Key? key, required this.index}) : super(key: key);

  @override
  State<ComplaintResponse> createState() => _ComplaintResponseState();
}

class _ComplaintResponseState extends State<ComplaintResponse> {
  late SettingsBloc bloc;
  late Timestamp time;

  @override
  void initState() {
    bloc = BlocProvider.of<SettingsBloc>(context);
    time = bloc.docData[widget.index]['msgTimestamp'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complaint',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: DecorationBoxWidget(
        color: ColorsExtensions.setColorOfContainersOverMap(context),
        radius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecorationBoxWidget(
                radius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      bloc.docData[widget.index]['message'],
                      textDirection: RegExp(r'^[A-Za-z0-9_.]+$').hasMatch(bloc
                              .docData[widget.index]['message']
                              .toString()[0])
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    StringsExtensions.splitDate(time)[0],
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'You',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 18),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.green,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: bloc.docData[widget.index]['response'] == null
                    ? false
                    : true,
                child: Column(
                  children: [
                    DecorationBoxWidget(
                      radius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            bloc.docData[widget.index]['response'] ?? '',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.blue,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Unibus',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 18),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          StringsExtensions.splitDate(time)[0],
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
