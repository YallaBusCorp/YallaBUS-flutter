import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/home/presentation/bloc/map/map_bloc.dart';
import 'package:yalla_bus/features/home/presentation/widgets/controllers.dart';
import 'package:yalla_bus/features/home/presentation/widgets/depart_at.dart';
import 'package:yalla_bus/features/home/presentation/widgets/from_to_widget.dart';
import 'package:yalla_bus/features/home/presentation/widgets/map.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>  {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: ValuesManager.v1,
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
