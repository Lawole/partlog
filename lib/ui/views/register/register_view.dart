import 'package:flutter/material.dart';
import 'package:partlog/ui/views/register/register_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/custom_text_field.dart';

class RegisterView extends StackedView<RegisterViewModel> {
  const RegisterView({super.key});

  @override
  Widget builder(
    BuildContext context,
    RegisterViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
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
            CustomTextField(
              label: 'Password',
              obscureText: true,
              controller: viewModel.passwordController,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: viewModel.isBusy ? null : viewModel.register,
              child: viewModel.isBusy
                  ? const CircularProgressIndicator()
                  : const Text('Register'),
            ),
            TextButton(
              onPressed: viewModel.navigateToLogin,
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  RegisterViewModel viewModelBuilder(BuildContext context) =>
      RegisterViewModel();
}
