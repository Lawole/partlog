import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../app/app.router.dart';
import '../../../services/api/api_service.dart';
import '../../../services/api/data/utils_service.dart';

class RegisterViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _utilsService = locator<UtilsService>();
  final _navigationService = locator<NavigationService>();
  final log = getLogger('RegisterViewModel');

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> register() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter both email and password',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIosWeb: 3,
      );
      return;
    }
    log.i('Starting registration, setting busy state');
    // setBusy(true);
    try {
      final user = await _apiService.register(
        emailController.text,
        passwordController.text,
      );
      if (user != null) {
        log.i('Registration successful, navigating to HomeView');
        await _navigationService.navigateTo(
          Routes.homeView,
          arguments: {'token': user.token},
        );
      }
    } catch (e) {
      String errorMessage = 'Registration failed';
      if (e is DioException && e.response != null) {
        if (e.response!.statusCode == 401) {
          errorMessage = 'Unauthorized: Invalid credentials or API issue';
        } else if (e.response!.data['error'] != null) {
          errorMessage = e.response!.data['error'];
        } else {
          errorMessage = 'Error: ${e.response!.statusCode} - ${e.response!.data}';
        }
      } else {
        errorMessage = e.toString();
      }
      log.e('Registration error: $errorMessage');
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIosWeb: 3,
      );
    } finally {
      log.i('Dismissing loading state');
      setBusy(false); // Should trigger EasyLoading.dismiss()
    }
  }

  void navigateToLogin() {
    _navigationService.navigateTo(Routes.loginView);
  }

  @override
  void setBusy(bool value) {
    log.i('Setting busy state: $value');
    _utilsService.initiateLoading(value);
    super.setBusy(value);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}