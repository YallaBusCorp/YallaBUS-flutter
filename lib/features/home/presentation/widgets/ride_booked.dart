import 'package:flutter/material.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/home/presentation/widgets/driver_info.dart';
import 'package:yalla_bus/features/home/presentation/widgets/ride_controllers.dart';
import 'package:yalla_bus/features/home/presentation/widgets/ride_info.dart';

class RideBooked extends StatelessWidget {
  const RideBooked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height - 380,
      left: MediaQuery.of(context).size.width / 30,
      child: Container(
        width: MediaQuery.of(context).size.width - ValuesManager.v20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ValuesManager.v16),
          boxShadow: selectShadow(context),
          color: ColorsExtensions.setColorOfContainersOverMap(context),
        ),
        child: Padding(
          padding: const EdgeInsets.all(ValuesManager.v16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              DriverInfo(),
              SizedBox(
                height: 10,
              ),
              RideInfo(),
              SizedBox(
                height: 10,
              ),
              RideControllers(),
            ],
          ),
        ),
      ),
    );
  }
}
