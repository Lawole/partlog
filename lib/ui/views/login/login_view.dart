import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:partlog/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/button.dart';
import '../../widgets/custom_password_input.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_textformfield.dart';
import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _iconController;

  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _fadeAnimations;
  late Animation<double> _iconScale;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    // Icon scale animation
    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _iconController,
      curve: Curves.elasticOut,
    ));

    // Build staggered animations
    _slideAnimations = List.generate(5, (index) {
      return Tween<Offset>(
        begin: Offset(0, 0.2),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _mainController,
          curve:
              Interval(0.1 * index, 0.1 * index + 0.5, curve: Curves.easeOut),
        ),
      );
    });

    _fadeAnimations = List.generate(5, (index) {
      return Tween<double>(
        begin: 0,
        end: 1,
      ).animate(
        CurvedAnimation(
          parent: _mainController,
          curve: Interval(0.1 * index, 0.1 * index + 0.5, curve: Curves.easeIn),
        ),
      );
    });

    _iconController.forward();
    _mainController.forward();
  }

  @override
  void dispose() {
    _mainController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: Stack(
          children: [
            // Background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/images/rm222-mind-14.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
            ),

            viewModel.isBusy
                ? Center(
                    child: Lottie.asset(
                      "asset/lottie/loading_state.json",
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                    ),
                  )
                : SingleChildScrollView(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            verticalSpaceLarge,
                            ScaleTransition(
                              scale: _iconScale,
                              child: const Icon(Iconsax.lock,
                                  size: 100, color: Colors.white),
                            ),
                            SlideTransition(
                              position: _slideAnimations[0],
                              child: FadeTransition(
                                opacity: _fadeAnimations[0],
                                child: const Text(
                                  'Welcome Back',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            verticalSpaceLarge,
                            SlideTransition(
                              position: _slideAnimations[1],
                              child: FadeTransition(
                                opacity: _fadeAnimations[1],
                                child: CustomInputField(
                                  labelText: 'Email Address',
                                  controller: viewModel.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty)
                                      return 'Email is required';
                                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                        .hasMatch(value)) {
                                      return 'Enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            verticalSpaceMedium,
                            SlideTransition(
                              position: _slideAnimations[2],
                              child: FadeTransition(
                                opacity: _fadeAnimations[2],
                                child: CustomInputFieldPassword(
                                  labelText: 'Password',
                                  controller: viewModel.passwordController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty)
                                      return 'Password is required';
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SlideTransition(
                              position: _slideAnimations[3],
                              child: FadeTransition(
                                opacity: _fadeAnimations[3],
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed:
                                        viewModel.navigateToForgotPassword,
                                    child: const Text(
                                      'Forgot Password?',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            SlideTransition(
                              position: _slideAnimations[4],
                              child: FadeTransition(
                                opacity: _fadeAnimations[4],
                                child: Column(
                                  children: [
                                    ButtonHot(
                                      label: 'Sign In',
                                      onPressed: viewModel.isBusy
                                          ? null
                                          : viewModel.login,
                                      isDisabled: !viewModel.isCredValid,
                                      width: double.infinity,
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Don\'t have an account?',
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                        TextButton(
                                          onPressed:
                                              viewModel.navigateToRegister,
                                          child: const Text(
                                            'Register',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
