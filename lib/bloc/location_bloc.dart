import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_am_driver/utils/custim_snack_bar.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<CheckLocationPermission>((event, emit) async {
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        if (event.context.mounted) {
          CustomSnackBar.show(
            message: 'This app needs access to your location',
            icon: Icons.location_on,
            context: event.context,
          );
        }
        emit(PermissionDenied());
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always) {
          emit(PermissionGranted());
        }
      } else if (permission == LocationPermission.deniedForever) {
        if (event.context.mounted) {
          CustomSnackBar.show(
            message: 'This app needs access to your location',
            icon: Icons.location_on,
            context: event.context,
          );
        }
        // Open app settings to grant permission
        emit(PermissionDenied());
        bool askAgain = await Geolocator.openAppSettings();
        if (askAgain) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.whileInUse ||
              permission == LocationPermission.always) {
            emit(PermissionGranted());
          }
        }
      } else {
        emit(PermissionGranted());
      }
    });

    on<GetLocation>((event, emit) async {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        double lat = position.latitude;
        double long = position.longitude;

        emit(LocationLoaded(latLng: LatLng(lat, long)));
      } on LocationServiceDisabledException {
        await Geolocator.openLocationSettings();
      }
    });

    on<GoToCurrentLocation>((event, emit) async {
      final GoogleMapController controller = await event.controller.future;

      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: event.latLng,
            zoom: 16,
          ),
        ),
      );
    });
  }
}
