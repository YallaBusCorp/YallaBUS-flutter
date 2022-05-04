import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/features/home/presentation/bloc/map/map_bloc.dart';
import 'package:yalla_bus/features/home/presentation/widgets/book_ride.dart';
import 'package:yalla_bus/features/home/presentation/widgets/qr_view.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/injection/di.dart';
import '../../../../core/resources/values_manager.dart';

class RideControllers extends StatelessWidget {
  const RideControllers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapBloc bloc = di<MapBloc>();
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ValuesManager.v16),
        boxShadow: selectShadow(context),
        color: Theme.of(context).backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ButtonWidget(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => const Dialog(
                          insetPadding: EdgeInsets.all(16),
                          child: QRView(),
                          backgroundColor: Colors.transparent),
                    );
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AssetManager.scan,
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      TextWidget(
                        text: 'QR code',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 16),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            ButtonWidget(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (builder) => const BookRide(),
                );
              },
              child: SvgPicture.asset(
                AssetManager.reschedule,
                width: 30,
                height: 30,
              ),
              width: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            ButtonWidget(
              onPressed: () {
                bloc.add(CancelRideEvent());
              },
              child: SvgPicture.asset(
                AssetManager.cancelIcon,
                width: 30,
                height: 30,
              ),
              width: 50,
            ),
          ],
        ),
      ),
    );
  }
}
