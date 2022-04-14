
import 'package:flutter/material.dart';
import 'package:yalla_bus/features/home/presentation/widgets/controllers.dart';
import 'package:yalla_bus/features/home/presentation/widgets/depart_at.dart';
import 'package:yalla_bus/features/home/presentation/widgets/from_to_widget.dart';
import 'package:yalla_bus/features/home/presentation/widgets/map.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // late BitmapDescriptor customIcon ;
  // @override
  // void initState() {
  //   getBytesFromAsset('assets/truck.png', 64).then((onValue) {
  //     customIcon =BitmapDescriptor.fromBytes(onValue);

  //   });
  //   super.initState();
  // }
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
  // static Future<Uint8List> getBytesFromAsset(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  // }
}
