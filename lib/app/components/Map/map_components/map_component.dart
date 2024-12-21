import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geeks_service/service/logger.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

import '../../forms/custom_text_field.dart';
import 'map_picker.dart';

class MapComponent extends HookWidget {
  MapComponent({
    super.key,
    required this.onConfirmAddress,
  });
  final void Function(String?, LatLng) onConfirmAddress;

  static final mapPickerController = MapPickerController();

  final box = Hive.box('positionBox');

  @override
  Widget build(BuildContext context) {
    final mapInputController = useTextEditingController();
    final position = useState<LatLng?>(null);
    Completer<GoogleMapController> controller = Completer();

    // final addressState = useState<String>('');

    var initialPosition = CameraPosition(
      target: LatLng(box.get('lat'), box.get('lng')),
      zoom: 14.4746,
    );

    final cameraPositionState = useState<CameraPosition>(initialPosition);
    // final CameraPosition _kLake = CameraPosition(
    //     bearing: 192.8334901395799,
    //     target: LatLng(37.43296265331129, -122.08832357078792),
    //     tilt: 59.440717697143555,
    //     zoom: 19.151926040649414);

    // Future<void> _goToTheLake() async {
    //   final GoogleMapController controller = await _controller.future;
    //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    // }

    return Scaffold(
      body: Stack(
        children: [
          MapPicker(
            // pass icon widget
            iconWidget: SvgPicture.asset(
              "assets/images/location_icon.svg",
              height: 60,
            ),
            //add map picker controller
            mapPickerController: mapPickerController,
            visible: true,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: initialPosition,
              onMapCreated: (GoogleMapController newController) async {
                controller.complete(newController);
              },
              onCameraMoveStarted: () {
                // notify map is moving
                mapPickerController.mapMoving!();
                // textController.text = "checking ...";
              },
              onCameraMove: (cameraPosition) {
                cameraPositionState.value = cameraPosition;
              },
              onCameraIdle: () async {
                // notify map stopped moving
                mapPickerController.mapFinishedMoving!();
                position.value = LatLng(
                    cameraPositionState.value.target.latitude,
                    cameraPositionState.value.target.longitude);
                //get address name from camera position
                List<Placemark> placemarks = await placemarkFromCoordinates(
                  cameraPositionState.value.target.latitude,
                  cameraPositionState.value.target.longitude,
                );
                if (placemarks.isNotEmpty) {
                  logger.i(placemarks[0].toString());
                  logger.i(
                    '${placemarks.first.street},${placemarks.first.subLocality},${placemarks.first.locality}',
                  );
                  mapInputController.text =
                      '${placemarks.first.thoroughfare},${placemarks.first.subLocality},${placemarks.first.locality}';
                  onConfirmAddress(mapInputController.text, position.value!);
                  logger.i(mapInputController.text);
                }
                // update the ui with the address
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: CustomTextField(
                  readOnly: true,
                  label: '',
                  controller: mapInputController,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        label: const Text('Confirm'),
        icon: const Icon(Icons.gps_not_fixed),
      ),
    );
  }
}

class MapPickerWidget extends GetWidget {
  const MapPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      init: MapController(),
      builder: (_) {
        return Scaffold(
          body: Stack(
            children: [
              MapPicker(
                // pass icon widget
                iconWidget: SvgPicture.asset(
                  "assets/images/location_icon.svg",
                  height: 60,
                ),
                //add map picker controller
                mapPickerController: _.mapPickerController,
                visible: true,
                child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _.initialPosition,
                    onMapCreated: (GoogleMapController newController) {
                      _.onMapCreated(newController);
                    },
                    onCameraMoveStarted: () {
                      // notify map is moving
                      _.onCameraMoveStarted();
                      // textController.text = "checking ...";
                    },
                    onCameraMove: (cameraPosition) {
                      _.onCameraMove(cameraPosition);
                    },
                    onCameraIdle: () {
                      _.onCameraIdl();
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: CustomTextField(
                      readOnly: true,
                      label: '',
                      controller: _.mapInputController,
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pop(context);
            },
            label: const Text('Confirm'),
            icon: const Icon(Icons.gps_not_fixed),
          ),
        );
      },
    );
  }
}

class MapController extends GetxController {
  TextEditingController mapInputController = TextEditingController();
  late LatLng position;
  Completer<GoogleMapController> controller = Completer();

  final mapPickerController = MapPickerController();

  final box = Hive.box('positionBox');

  // final addressState = useState<String>('');

  late CameraPosition initialPosition;

  late CameraPosition cameraPositionState;
  @override
  void onInit() {
    super.onInit();
    initialPosition = CameraPosition(
      target: LatLng(box.get('lat'), box.get('lng')),
      zoom: 14.4746,
    );
  }

  void onMapCreated(GoogleMapController newController) async {
    controller.complete(newController);
    update();
  }

  void onCameraMoveStarted() {
    mapPickerController.mapMoving!();
    update();
  }

  void onCameraMove(CameraPosition cameraPosition) {
    cameraPositionState = cameraPosition;
    update();
  }

  void onCameraIdl() async {
    // notify map stopped moving
    mapPickerController.mapFinishedMoving!();
    position = LatLng(cameraPositionState.target.latitude,
        cameraPositionState.target.longitude);
        
    //get address name from camera position
    List<Placemark> placemarks = await placemarkFromCoordinates(
      cameraPositionState.target.latitude,
      cameraPositionState.target.longitude,
    );
    if (placemarks.isNotEmpty) {
      logger.i(placemarks[0].toString());
      logger.i(
        '${placemarks.first.street},${placemarks.first.subLocality},${placemarks.first.locality}',
      );
      mapInputController.text =
          '${placemarks.first.thoroughfare},${placemarks.first.subLocality},${placemarks.first.locality}';
      logger.i(mapInputController.text);
    }
    update();
    // update the ui with the address
  }
}
