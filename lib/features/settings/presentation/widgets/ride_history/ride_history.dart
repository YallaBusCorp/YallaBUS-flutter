import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';
import 'package:yalla_bus/features/settings/domain/entity/ride_history_model.dart';
import 'package:yalla_bus/features/settings/domain/use_case/get_non_scanned_rides.dart';
import 'package:yalla_bus/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:yalla_bus/features/settings/presentation/widgets/ride_history/done_ride_history.dart';
import 'package:yalla_bus/features/settings/presentation/widgets/ride_history/missed_ride_history.dart';
import '../../../../../core/custom_widgets/error_dialog.dart';
import '../../../../../core/custom_widgets/loading_dialog.dart';
import 'ride_history_item.dart';

class RidesHistory extends StatefulWidget {
  const RidesHistory({Key? key}) : super(key: key);

  @override
  State<RidesHistory> createState() => _RidesHistoryState();
}

class _RidesHistoryState extends State<RidesHistory>
    with TickerProviderStateMixin {
  late TabController controller;
  List<RideHis>? nonScanned;
  List<RideHis> scanned = [];
  late SettingsBloc bloc;
  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    bloc = BlocProvider.of<SettingsBloc>(context);
    bloc.add(GetNotScannedRidesEvent(174));
    bloc.add(GetScannedRidesEvent(174));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ride History',
          style: Theme.of(context).textTheme.headline5,
        ),
        bottom: TabBar(
          labelColor: ColorsManager.orange,
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle:
              Theme.of(context).textTheme.headline5!.copyWith(fontSize: 18),
          indicatorColor: ColorsManager.orange,
          controller: controller,
          tabs: [
            Tab(
              child: Text(
                'Done',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontSize: 18),
              ),
            ),
            Tab(
              child: Text(
                'Missed',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      body: BlocConsumer<SettingsBloc, SettingsState>(
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
          if (state is GetNotScannedRidesSuccess) {
            Navigator.of(context).pop();
            nonScanned = state.list;
          }
          if (state is GetScannedRidesSuccess) {
            scanned = state.list;
          }
          if (state is GetNonScannedRidesError) {
            showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                backgroundColor: Colors.transparent,
                child: ErrorDialog(
                  message: 'Try again in another Time',
                  onTap: () {},
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return TabBarView(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            children: [
              DoneRideHistory(
                list: nonScanned ?? [],
              ),
              scanned.isEmpty
                  ? Center(
                      child: SvgPicture.asset(
                        AssetManager.error404,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : MissedRideHistory(
                      list: scanned,
                    ),
            ],
          );
        },
      ),
    );
  }
}
