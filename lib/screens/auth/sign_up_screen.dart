import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_driver/bloc/auth_bloc.dart';
import 'package:i_am_driver/utils/theme.dart';
import 'package:i_am_driver/widgets/auth_brand_banner.dart';
import 'package:i_am_driver/widgets/custom_filled_button.dart';
import 'package:i_am_driver/widgets/custom_form_field.dart';
import 'package:i_am_driver/widgets/custom_outline_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void toggleShowConfirmPassword() {
    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (value.length < 10 || int.tryParse(value) == null) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (!value.contains('@') || !value.contains('.')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void signup() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(Signup(
            name: _nameController.text,
            phoneNumber: _phoneController.text,
            email: _emailController.text,
            password: _passwordController.text,
            context: context,
          ));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Column(
              children: [
                AuthBrandBanner(
                  isLoginScreen: false,
                ),
                Divider(thickness: 2.0),
                const SizedBox(height: 32.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'Sign Up',
                        style: CustomTextStyles.lightMadimi.copyWith(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w700,
                          shadows: [
                            Shadow(
                              color: CustomColors.secondaryColor,
                              offset: const Offset(1.4, 1.4),
                              blurRadius: 20.0,
                            ),
                            Shadow(
                              color: CustomColors.primaryColor,
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      CustomFormField(
                        controller: _nameController,
                        validator: validateName,
                        keyboardType: TextInputType.name,
                        labelText: 'Name',
                        prefixIcon: CupertinoIcons.person,
                      ),
                      const SizedBox(height: 20.0),
                      CustomFormField(
                        controller: _phoneController,
                        validator: validatePhone,
                        keyboardType: TextInputType.phone,
                        labelText: 'Phone Number',
                        prefixIcon: CupertinoIcons.phone,
                      ),
                      const SizedBox(height: 20.0),
                      CustomFormField(
                        controller: _emailController,
                        validator: validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        labelText: 'Email',
                        prefixIcon: CupertinoIcons.mail,
                      ),
                      const SizedBox(height: 20.0),
                      CustomFormField(
                        obscureText: !_showPassword,
                        controller: _passwordController,
                        validator: validatePassword,
                        keyboardType: TextInputType.visiblePassword,
                        labelText: 'Password',
                        prefixIcon: CupertinoIcons.lock,
                        suffixIcon: IconButton(
                          onPressed: toggleShowPassword,
                          icon: Icon(
                            _showPassword
                                ? CupertinoIcons.eye_slash_fill
                                : CupertinoIcons.eye_fill,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      CustomFormField(
                        obscureText: !_showConfirmPassword,
                        controller: _confirmPasswordController,
                        validator: validateConfirmPassword,
                        keyboardType: TextInputType.visiblePassword,
                        labelText: 'Confirm Password',
                        prefixIcon: CupertinoIcons.padlock_solid,
                        suffixIcon: IconButton(
                          onPressed: toggleShowConfirmPassword,
                          icon: Icon(
                            _showPassword
                                ? CupertinoIcons.eye_slash_fill
                                : CupertinoIcons.eye_fill,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthenticatedState) {
                            Navigator.of(context).pushReplacementNamed(
                              '/home',
                            );
                          }
                        },
                        builder: (context, state) {
                          return CustomFilledButton(
                            onPressed:
                                (state is AuthLoadingState) ? null : signup,
                            text: 'Sign Up',
                          );
                        },
                      ),
                      const SizedBox(height: 20.0),
                      CustomOutlineButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        text: 'Sign In',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
