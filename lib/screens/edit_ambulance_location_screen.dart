import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_am_driver/bloc/ambulance_bloc.dart';
import 'package:i_am_driver/bloc/auth_bloc.dart';
import 'package:i_am_driver/bloc/location_bloc.dart';
import 'package:i_am_driver/utils/theme.dart';
import 'package:i_am_driver/widgets/custom_filled_button.dart';

class EditAmbulanceLocationScreen extends StatefulWidget {
  const EditAmbulanceLocationScreen({super.key});

  @override
  State<EditAmbulanceLocationScreen> createState() =>
      _EditAmbulanceLocationScreenState();
}

class _EditAmbulanceLocationScreenState
    extends State<EditAmbulanceLocationScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    context.read<LocationBloc>().add(GetLocation());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    context.read<AmbulanceBloc>().add(CancelEditAmbulanceEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Stack(children: [
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthenticatedState) {
              double currentLatitude = state.user.ambulance!.latitude!;
              double currentLongitude = state.user.ambulance!.longitude!;
              return Column(
                children: [
                  Expanded(
                    child: BlocListener<LocationBloc, LocationState>(
                      listener: (context, state) {
                        if (state is LocationLoaded) {
                          context.read<LocationBloc>().add(GoToCurrentLocation(
                              latLng: LatLng(currentLatitude, currentLongitude),
                              controller: _controller));
                        }
                      },
                      child: GoogleMap(
                        myLocationEnabled: true,
                        mapType: MapType.hybrid,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(-6.1944, 106.8229),
                          zoom: 17.5,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        markers: {
                          Marker(
                            markerId: MarkerId('${state.user.ambulance!.id}'),
                            position: LatLng(currentLatitude, currentLongitude),
                            infoWindow: InfoWindow(title: 'My Ambulance Base'),
                            draggable: true,
                            zIndex: 99,
                            onDragEnd: (value) {
                              currentLatitude = value.latitude;
                              currentLongitude = value.longitude;
                              context.read<AmbulanceBloc>().add(
                                    EditLocationAmbulanceEvent(latLng: value),
                                  );
                            },
                          ),
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      children: [
                        Text(
                          'Edit Ambulance Location',
                          style: CustomTextStyles.darkMadimi.copyWith(
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        BlocBuilder<AmbulanceBloc, AmbulanceState>(
                          builder: (context, state) {
                            return Wrap(
                              spacing: 10.0,
                              runSpacing: 10.0,
                              children: [
                                Text(
                                  'Latitude : ${(state is AmbulanceEditLocationState) ? state.latLng.latitude : currentLatitude}',
                                  style: CustomTextStyles.dark.copyWith(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Longitude : ${(state is AmbulanceEditLocationState) ? state.latLng.longitude : currentLongitude}',
                                  style: CustomTextStyles.dark.copyWith(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 50.0),
                        BlocListener<AmbulanceBloc, AmbulanceState>(
                          listener: (context, state) {
                            if (state is AmbulanceSuccessState) {
                              context.read<AuthBloc>().add(AppStarted());
                              Navigator.of(context).pop();
                            }
                          },
                          child: CustomFilledButton(
                            onPressed: () {
                              context.read<AmbulanceBloc>().add(
                                  UpdateLocationAmbulanceEvent(
                                      context: context,
                                      latLng: LatLng(
                                          currentLatitude, currentLongitude)));
                            },
                            text: 'Update Location',
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
        Positioned(
          top: 14,
          left: 16,
          child: BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: CustomColors.lightColor,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                CustomColors.secondaryColor.withOpacity(0.6),
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.all(10.0),
              ),
              iconSize: MaterialStateProperty.all(28.0),
            ),
          ),
        ),
      ]),
    );
  }
}
