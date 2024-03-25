import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_am_driver/bloc/ambulance_bloc.dart';
import 'package:i_am_driver/bloc/auth_bloc.dart';
import 'package:i_am_driver/bloc/location_bloc.dart';
import 'package:i_am_driver/utils/theme.dart';
import 'package:i_am_driver/widgets/custom_filled_button.dart';

class RegisterLocationAmbulanceScreen extends StatefulWidget {
  final String model;
  final String licensePlate;
  const RegisterLocationAmbulanceScreen({
    super.key,
    required this.model,
    required this.licensePlate,
  });

  @override
  State<RegisterLocationAmbulanceScreen> createState() =>
      _RegisterLocationAmbulanceScreenState();
}

class _RegisterLocationAmbulanceScreenState
    extends State<RegisterLocationAmbulanceScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void didChangeDependencies() {
    context.read<AmbulanceBloc>().add(CancelEditAmbulanceEvent());
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    context.read<LocationBloc>().add(GetLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                BlocConsumer<LocationBloc, LocationState>(
                  listener: (context, state) {
                    if (state is LocationLoaded) {
                      context.read<LocationBloc>().add(GoToCurrentLocation(
                          latLng: state.latLng, controller: _controller));
                    }
                  },
                  builder: (context, state) {
                    LatLng location = (state is LocationLoaded)
                        ? state.latLng
                        : LatLng(-6.1944, 106.8229);
                    return GoogleMap(
                      myLocationEnabled: true,
                      mapType: MapType.hybrid,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(-6.1944, 106.8229),
                        zoom: 17.5,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      onTap: (argument) {
                        context.read<AmbulanceBloc>().add(
                              EditLocationAmbulanceEvent(
                                latLng: argument,
                              ),
                            );
                      },
                      markers: {
                        Marker(
                          markerId: MarkerId('My Ambulance Base'),
                          position:
                              LatLng(location.latitude, location.longitude),
                          infoWindow: InfoWindow(title: 'My Ambulance Base'),
                          draggable: true,
                          zIndex: 99,
                          onDragEnd: (value) {
                            location = value;
                            context.read<AmbulanceBloc>().add(
                                  EditLocationAmbulanceEvent(latLng: value),
                                );
                          },
                        ),
                      },
                    );
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
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Ambulance Information',
                    style: CustomTextStyles.secondaryMadimi.copyWith(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Model :',
                      style: CustomTextStyles.dark.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.model,
                        style: CustomTextStyles.dark.copyWith(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'License Plate :',
                      style: CustomTextStyles.dark.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.licensePlate,
                        style: CustomTextStyles.dark.copyWith(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Latitude :',
                      style: CustomTextStyles.dark.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<AmbulanceBloc, AmbulanceState>(
                        builder: (context, state) {
                          return Text(
                            (state is AmbulanceEditLocationState)
                                ? state.latLng.latitude.toString()
                                : 'Not Set',
                            style: CustomTextStyles.dark.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.end,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Longitude :',
                      style: CustomTextStyles.dark.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<AmbulanceBloc, AmbulanceState>(
                        builder: (context, state) {
                          return Text(
                            (state is AmbulanceEditLocationState)
                                ? state.latLng.longitude.toString()
                                : 'Not Set',
                            style: CustomTextStyles.dark.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.end,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                const SizedBox(height: 20.0),
                BlocConsumer<AmbulanceBloc, AmbulanceState>(
                  listener: (context, state) {
                    if (state is AmbulanceSuccessState) {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/home', (route) => false);
                      context.read<AuthBloc>().add(AppStarted());
                    }
                  },
                  builder: (context, state) {
                    return CustomFilledButton(
                      onPressed: (state is AmbulanceEditLocationState)
                          ? () {
                              context.read<AmbulanceBloc>().add(
                                  RegisterAmbulanceEvent(
                                      context: context,
                                      model: widget.model,
                                      licensePlate: widget.licensePlate,
                                      latLng: state.latLng));
                            }
                          : null,
                      text: 'Register Ambulance',
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
