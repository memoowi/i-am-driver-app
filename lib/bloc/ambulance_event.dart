part of 'ambulance_bloc.dart';

@immutable
sealed class AmbulanceEvent {}

class EditAmbulanceEvent extends AmbulanceEvent {}

class CancelEditAmbulanceEvent extends AmbulanceEvent {}

class UpdateBasicAmbulanceEvent extends AmbulanceEvent {
  final BuildContext context;
  final String model;
  final String licensePlate;

  UpdateBasicAmbulanceEvent(
      {required this.context, required this.model, required this.licensePlate});
}

class EditLocationAmbulanceEvent extends AmbulanceEvent {
  final LatLng latLng;

  EditLocationAmbulanceEvent({required this.latLng});
}

class UpdateLocationAmbulanceEvent extends AmbulanceEvent {
  final BuildContext context;
  final LatLng latLng;

  UpdateLocationAmbulanceEvent({required this.context, required this.latLng});
}
