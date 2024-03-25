import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_driver/bloc/location_bloc.dart';
import 'package:i_am_driver/utils/theme.dart';
import 'package:i_am_driver/widgets/custom_filled_button.dart';

class NoAmbulancePage extends StatelessWidget {
  const NoAmbulancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            'You haven\'t registered an Ambulance.\nPlease register an Ambulance first...',
            style: CustomTextStyles.secondaryMadimi.copyWith(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 28.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: BlocListener<LocationBloc, LocationState>(
            listener: (context, state) {
              if (state is PermissionGranted) {
                Navigator.of(context).pushNamed('/register_ambulance');
              }
            },
            child: CustomFilledButton(
              text: 'Register Ambulance Now',
              onPressed: () {
                context
                    .read<LocationBloc>()
                    .add(CheckLocationPermission(context: context));
              },
            ),
          ),
        ),
      ],
    );
  }
}
