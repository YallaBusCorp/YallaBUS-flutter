import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/home/presentation/widgets/controllers.dart';
import 'package:yalla_bus/features/home/presentation/widgets/depart_at.dart';
import 'package:yalla_bus/features/home/presentation/widgets/from_to_widget.dart';
import 'package:yalla_bus/features/home/presentation/widgets/map.dart';

import '../../../../core/custom_widgets/separtor_widget.dart';
import '../../../../core/position_locator/locator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 1,
      ),
      body: Stack(
        children: const [
          MapWidget(),
          Controllers(),
          FromToWidget(),
          DepartAt(),
        ],
      ),
    );
  }
}
