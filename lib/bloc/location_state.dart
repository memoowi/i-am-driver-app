part of 'location_bloc.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

class PermissionDenied extends LocationState {}

class PermissionGranted extends LocationState {}

class LocationLoaded extends LocationState {
  final LatLng latLng;

  LocationLoaded({required this.latLng});
}
