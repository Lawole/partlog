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

class LoginViewModel extends FormViewModel {
  final _apiService = locator<ApiService>();
  final _utilsService = locator<UtilsService>();
  final _navigationService = locator<NavigationService>();
  final log = getLogger('LoginViewModel');

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginViewModel() {
    emailController.addListener(notifyListeners);
    passwordController.addListener(notifyListeners);
  }

  bool get isCredValid {
    final email = emailController.text;
    final password = passwordController.text;
    return email.isNotEmpty &&
        RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email) &&
        password.isNotEmpty &&
        password.length >= 6;
  }

  Future<void> login() async {
    if (!isCredValid) {
      Fluttertoast.showToast(
        msg: 'Please enter valid email and password',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIosWeb: 3,
      );
      return;
    }
    log.i('Starting login, setting busy state');
    setBusy(true);
    try {
      final user = await _apiService.login(
        emailController.text,
        passwordController.text,
      );
      if (user != null) {
        log.i('Login successful, navigating to HomeView');
        await _navigationService.clearStackAndShow(
          Routes.homeView,
          arguments: {'token': user.token},
        );
      }
    } catch (e) {
      String errorMessage = 'Login failed';
      if (e is DioException && e.response != null) {
        if (e.response!.statusCode == 401) {
          errorMessage = 'Unauthorized: Invalid credentials or API issue';
        } else if (e.response!.data['error'] != null) {
          errorMessage = e.response!.data['error'];
        } else {
          errorMessage =
              'Error: ${e.response!.statusCode} - ${e.response!.data}';
        }
      } else {
        errorMessage = e.toString();
      }
      log.e('Login error: $errorMessage');
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIosWeb: 3,
      );
    } finally {
      log.i('Dismissing loading state');
      setBusy(false);
    }
  }

  void navigateToRegister() {
    _navigationService.navigateTo(Routes.registerView);
  }

  void navigateToForgotPassword() {
    // _navigationService.navigateTo(Routes.forgotPasswordView);
  }

  void goBack() {
    _navigationService.back();
  }

  // @override
  // void setBusy(bool value) {
  //   log.i('Setting busy state: $value');
  //   _utilsService.initiateLoading(value);
  //   super.setBusy(value);
  // }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
