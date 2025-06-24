import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:partlog/ui/common/text_styles.dart';
import 'package:partlog/ui/views/register/register_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_password_input.dart';
import '../../widgets/custom_textformfield.dart';

class RegisterView extends StackedView<RegisterViewModel> {
  const RegisterView({super.key});

  @override
  Widget builder(
      BuildContext context,
      RegisterViewModel viewModel,
      Widget? child,
      ) {
    return Scaffold(
      body: Stack(
        children: [
        // Background image
        Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/images/v904-nunny-010-f.jpg'),
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
        ),
      ),
      Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.3),
      ),
      // Form content
          viewModel.isBusy ? Center(
            child: Lottie.asset(
              "asset/lottie/loading_state.json",
              width: 80,
              height: 80,
              alignment: Alignment.center,
            ),
          ):
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: viewModel.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: viewModel.goBack,
                    icon: const Icon(Iconsax.arrow_left),
                    alignment: Alignment.topLeft,),
                  const Text(
                    'Register',
                    style: TextStyle(
                      color: kcPrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Unlock seamless smart living at PartLog with personalized control',
                    style: ktBodyRegularSize14.copyWith(
                      color: kcPrimaryColor,
                    ),
                  ),
                  verticalSpaceMassive,
                  CustomInputField(
                    labelText: 'Enter Full Name',
                    controller: viewModel.fullNameController,
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value!.isEmpty ? 'Full name is required' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    labelText: 'Enter Email',
                    controller: viewModel.emailController,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) return 'Email is required';
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomInputFieldPassword(
                    labelText: 'Enter Password',
                    controller: viewModel.passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) return 'Password is required';
                      if (value.length < 6) return 'Password must be at least 6 characters';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomInputFieldPassword(
                    labelText: 'Confirm Password',
                    controller: viewModel.confirmPasswordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) return 'Confirm password is required';
                      if (value != viewModel.passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        activeColor: kcPrimaryColor,
                        value: viewModel.isChecked,
                        onChanged: viewModel.toggleCheckbox,
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: 'By creating an account you agree to our ',
                            style: const TextStyle(
                              fontSize: 14,
                              color: kcGray0,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'MADE TOMMY',
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms of Use',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: kcPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'MADE TOMMY',
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {},
                              ),
                              const TextSpan(
                                text: ' and ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: kcGray0,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'MADE TOMMY',
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: kcPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'MADE TOMMY',
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (viewModel.showCheckboxError)
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 4.0),
                      child: Text(
                        'You must agree to the Terms of Use and Privacy Policy',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  verticalSpaceLarge,

                  ButtonHot(
                    label: "Register",
                    onPressed: viewModel.isBusy ? null : () => viewModel.register(),
                    isDisabled: !viewModel.isFormValid,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: TextButton(
                      onPressed: viewModel.navigateToLogin,
                      child: const Text('Already have an account? Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
    ),
    );
  }

  @override
  RegisterViewModel viewModelBuilder(BuildContext context) => RegisterViewModel();
}