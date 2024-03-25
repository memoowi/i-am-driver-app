part of 'ambulance_bloc.dart';

@immutable
sealed class AmbulanceState {}

final class AmbulanceInitial extends AmbulanceState {}

class AmbulanceEditState extends AmbulanceState {}

class AmbulanceSuccessState extends AmbulanceState {}
