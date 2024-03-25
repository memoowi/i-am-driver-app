import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_driver/bloc/ambulance_bloc.dart';
import 'package:i_am_driver/bloc/auth_bloc.dart';
import 'package:i_am_driver/utils/theme.dart';
import 'package:i_am_driver/widgets/custom_filled_button.dart';
import 'package:i_am_driver/widgets/custom_form_field.dart';
import 'package:i_am_driver/widgets/custom_outline_button.dart';

class AmbulancePage extends StatefulWidget {
  const AmbulancePage({super.key});

  @override
  State<AmbulancePage> createState() => _AmbulancePageState();
}

class _AmbulancePageState extends State<AmbulancePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController modelController = TextEditingController();
  TextEditingController licensePlateController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

  String? validateModel(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  String? validateLicensePlate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    modelController.dispose();
    licensePlateController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthenticatedState) {
              if (state.user.ambulance != null) {
                modelController.text = state.user.ambulance!.model!;
                licensePlateController.text =
                    state.user.ambulance!.licensePlate!;
                latitudeController.text =
                    state.user.ambulance!.latitude!.toString();
                longitudeController.text =
                    state.user.ambulance!.longitude!.toString();
                return Container(
                  margin: EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ambulance Details',
                          style: CustomTextStyles.primaryMadimi.copyWith(
                            fontSize: 22.0,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Ambulance Model :',
                          style: CustomTextStyles.dark.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        BlocBuilder<AmbulanceBloc, AmbulanceState>(
                          builder: (context, state) {
                            return CustomFormField(
                              controller: modelController,
                              validator: validateModel,
                              prefixIcon: CupertinoIcons.bus,
                              labelText: 'Ambulance Model',
                              readOnly:
                                  (state is AmbulanceEditState) ? false : true,
                            );
                          },
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'License Plate :',
                          style: CustomTextStyles.dark.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        BlocBuilder<AmbulanceBloc, AmbulanceState>(
                          builder: (context, state) {
                            return CustomFormField(
                              controller: licensePlateController,
                              validator: validateLicensePlate,
                              prefixIcon: CupertinoIcons.square_grid_3x2_fill,
                              labelText: 'License Plate',
                              readOnly:
                                  (state is AmbulanceEditState) ? false : true,
                            );
                          },
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Latitude :',
                              style: CustomTextStyles.dark.copyWith(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            BlocBuilder<AmbulanceBloc, AmbulanceState>(
                              builder: (context, state) {
                                if (state is AmbulanceEditState) {
                                  return Text(
                                    "*can't update this field here*",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                }
                                return SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        CustomFormField(
                          controller: latitudeController,
                          prefixIcon: CupertinoIcons.location_circle,
                          labelText: 'Latitude',
                          readOnly: true,
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Longitude :',
                              style: CustomTextStyles.dark.copyWith(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            BlocBuilder<AmbulanceBloc, AmbulanceState>(
                              builder: (context, state) {
                                if (state is AmbulanceEditState) {
                                  return Text(
                                    "*can't update this field here*",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                }
                                return SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        CustomFormField(
                          controller: longitudeController,
                          prefixIcon: CupertinoIcons.location_circle_fill,
                          labelText: 'Longitude',
                          readOnly: true,
                        ),
                        SizedBox(height: 20.0),
                        BlocBuilder<AmbulanceBloc, AmbulanceState>(
                          builder: (context, state) {
                            return Row(
                              children: [
                                if (state is! AmbulanceEditState)
                                  Expanded(
                                    child: CustomFilledButton(
                                      text: 'Edit',
                                      onPressed: () {
                                        context
                                            .read<AmbulanceBloc>()
                                            .add(EditAmbulanceEvent());
                                      },
                                    ),
                                  ),
                                if (state is AmbulanceEditState)
                                  ...edittingButton(),
                              ],
                            );
                          },
                        ),
                        Divider(
                          thickness: 2,
                          height: 30,
                          color: CustomColors.secondaryColor,
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(CupertinoIcons.location_fill),
                          label: Text('Edit Base Location'),
                          style: TextButton.styleFrom(
                            textStyle: CustomTextStyles.primaryMadimi.copyWith(
                              fontSize: 16,
                            ),
                            backgroundColor: CustomColors.lightColor,
                            foregroundColor: CustomColors.primaryColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 14,
                            ),
                            minimumSize: Size(double.infinity, 50),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              } else {
                return Text('No ambulance found'); // SEMENTARA
              }
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> edittingButton() {
    return [
      Expanded(
        child: CustomOutlineButton(
          text: 'Cancel',
          onPressed: () {
            context.read<AmbulanceBloc>().add(CancelEditAmbulanceEvent());
            context.read<AuthBloc>().add(AppStarted());
          },
        ),
      ),
      SizedBox(width: 10.0),
      Expanded(
        child: BlocListener<AmbulanceBloc, AmbulanceState>(
          listener: (context, state) {
            if (state is AmbulanceSuccessState) {
              context.read<AuthBloc>().add(AppStarted());
            }
          },
          child: CustomFilledButton(
            text: 'Save',
            onPressed: () {
              context.read<AmbulanceBloc>().add(UpdateBasicAmbulanceEvent(
                    context: context,
                    licensePlate: licensePlateController.text,
                    model: modelController.text,
                  ));
            },
          ),
        ),
      ),
    ];
  }
}
