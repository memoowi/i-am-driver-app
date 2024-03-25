import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_am_driver/utils/theme.dart';
import 'package:i_am_driver/widgets/custom_filled_button.dart';
import 'package:i_am_driver/widgets/custom_form_field.dart';

class RegisterAmbulanceScreen extends StatefulWidget {
  const RegisterAmbulanceScreen({super.key});

  @override
  State<RegisterAmbulanceScreen> createState() =>
      _RegisterAmbulanceScreenState();
}

class _RegisterAmbulanceScreenState extends State<RegisterAmbulanceScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _plateController = TextEditingController();

  String? validateModel(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  String? validatePlate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/register_ambulance_location', arguments: {
        'model': _modelController.text,
        'license_plate': _plateController.text
      });
    }
  }

  @override
  void dispose() {
    _modelController.dispose();
    _plateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      backgroundColor: CustomColors.lightColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Register An Ambulance',
                  style: CustomTextStyles.primaryMadimi.copyWith(
                    fontSize: 22.0,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ambulance Model :',
                      style: CustomTextStyles.dark.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    CustomFormField(
                      controller: _modelController,
                      validator: validateModel,
                      keyboardType: TextInputType.text,
                      labelText: 'Model',
                      prefixIcon: CupertinoIcons.bus,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'License Plate :',
                      style: CustomTextStyles.dark.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    CustomFormField(
                      controller: _plateController,
                      validator: validatePlate,
                      keyboardType: TextInputType.text,
                      labelText: 'License Plate',
                      prefixIcon: CupertinoIcons.textformat_abc,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 48.0),
              CustomFilledButton(
                text: 'Next',
                onPressed: submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
