import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/custom_password_input.dart';
import '../../widgets/custom_text_field.dart';
import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              label: 'Email',
              controller: viewModel.emailController,
            ),
            const SizedBox(height: 16),
            // CustomTextField(
            //   label: 'Password',
            //   obscureText: true,
            //   controller: viewModel.passwordController,
            // ),
            CustomInputFieldPassword(
              labelText: 'Password',
              controller: viewModel.passwordController,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: viewModel.isBusy ? null : viewModel.login,
              child: viewModel.isBusy
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            ),
            TextButton(
              onPressed: viewModel.navigateToRegister,
              child: const Text('Don\'t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();
}
