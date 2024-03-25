import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_am_driver/bloc/location_bloc.dart';
import 'package:i_am_driver/models/booking_list_model.dart';
import 'package:i_am_driver/utils/theme.dart';

class BookingLocationScreen extends StatefulWidget {
  final BookingData data;
  const BookingLocationScreen({super.key, required this.data});

  @override
  State<BookingLocationScreen> createState() => _BookingLocationScreenState();
}

class _BookingLocationScreenState extends State<BookingLocationScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      context.read<LocationBloc>().add(GoToCurrentLocation(
          latLng: LatLng(widget.data.latitude!, widget.data.longitude!),
          controller: _controller));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0.0),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
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
                      markerId: MarkerId('${widget.data.id}'),
                      position:
                          LatLng(widget.data.latitude!, widget.data.longitude!),
                      infoWindow: InfoWindow(
                        title: 'Customer Location : ${widget.data.user!.name}',
                        snippet: '${widget.data.description}',
                      ),
                    ),
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
              children: [
                Text(
                  'Booking Location',
                  style: CustomTextStyles.primaryMadimi.copyWith(
                    fontSize: 20.0,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(color: CustomColors.primaryColor)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Customer Name :',
                            style: CustomTextStyles.dark.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${widget.data.user!.name}',
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
                      SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Description :',
                            style: CustomTextStyles.dark.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${widget.data.description}',
                              style: CustomTextStyles.dark.copyWith(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.end,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
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
                            child: Text(
                              '${widget.data.latitude}',
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
                      SizedBox(height: 4.0),
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
                            child: Text(
                              '${widget.data.longitude}',
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
