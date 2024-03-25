part of 'ambulance_bloc.dart';

@immutable
sealed class AmbulanceState {}

final class AmbulanceInitial extends AmbulanceState {}

class AmbulanceEditState extends AmbulanceState {}

class AmbulanceEditLocationState extends AmbulanceState {
  final LatLng latLng;
  AmbulanceEditLocationState({required this.latLng});
}

class AmbulanceSuccessState extends AmbulanceState {}
