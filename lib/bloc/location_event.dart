part of 'location_bloc.dart';

@immutable
sealed class LocationEvent {}

class CheckLocationPermission extends LocationEvent {
  final BuildContext context;

  CheckLocationPermission({required this.context});
}

class GetLocation extends LocationEvent {}

class GoToCurrentLocation extends LocationEvent {
  // final BuildContext context;
  final LatLng latLng;
  final Completer<GoogleMapController> controller;

  GoToCurrentLocation({
    // required this.context,
    required this.latLng,
    required this.controller,
  });
}
