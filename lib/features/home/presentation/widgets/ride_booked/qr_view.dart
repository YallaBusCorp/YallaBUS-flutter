import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';

import '../../../../../core/custom_widgets/separtor_widget.dart';
import '../../../../../core/custom_widgets/text_widget.dart';
import '../../../../../core/resources/string_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../bloc/map/map_bloc.dart';

class QRView extends StatefulWidget {
  const QRView({Key? key}) : super(key: key);

  @override
  State<QRView> createState() => _QRViewState();
}

class _QRViewState extends State<QRView> {
  late MapBloc bloc;
  late String date;
  @override
  void initState() {
    bloc = BlocProvider.of<MapBloc>(context);
    date = bloc.perfs.getString(ConstantsManager.dateOfRide) ?? '05:52 AM';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: QrImage(
              data: bloc.perfs.getString(ConstantsManager.qrCode)!,
              version: QrVersions.auto,
              backgroundColor: Colors.white,
              size: 200,
            ),
          ),
          Separtor(
            color: [
              Colors.grey.shade800,
              Colors.grey.shade800,
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(ValuesManager.v16),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: TextWidget(
                  text: StringManager.cancel,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.blue[900],
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
