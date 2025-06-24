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

  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isChecked = false;
  bool get isChecked => _isChecked;

  bool _showCheckboxError = false;
  bool get showCheckboxError => _showCheckboxError;

  RegisterViewModel() {
    fullNameController.addListener(_onTextChanged);
    emailController.addListener(_onTextChanged);
    passwordController.addListener(_onTextChanged);
    confirmPasswordController.addListener(_onTextChanged);
  }

  void toggleCheckbox(bool? value) {
    _isChecked = value ?? false;
    _showCheckboxError = false;
  notifyListeners();
  }

  bool get isFormValid {
    return fullNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text) &&
        passwordController.text.isNotEmpty &&
        passwordController.text.length >= 6 &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text &&
        _isChecked;
  }

  void _onTextChanged() {
    notifyListeners();
  }

  Future<void> register() async {
    _showCheckboxError = false; // Reset checkbox error
    if (!formKey.currentState!.validate()) {
      Fluttertoast.showToast(
        msg: 'Please fill out all fields correctly',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIosWeb: 3,
      );
      return;
    }

    if (!_isChecked) {
      _showCheckboxError = true; // Show checkbox error
      notifyListeners();
      Fluttertoast.showToast(
        msg: 'You must agree to the Terms of Use and Privacy Policy',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIosWeb: 3,
      );
      return;
    }

    if (!isFormValid) {
      Fluttertoast.showToast(
        msg: 'Please ensure all fields are valid',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIosWeb: 3,
      );
      return;
    }

    // Check for valid ReqRes credentials
    if (emailController.text != 'eve.holt@reqres.in' || passwordController.text != 'pistol') {
      Fluttertoast.showToast(
        msg: 'Please enter valid ReqRes credentials (email: eve.holt@reqres.in, password: pistol) to continue',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.orangeAccent,
        textColor: Colors.white,
        timeInSecForIosWeb: 3,
      );
      return;
    }

    log.i('Starting registration, setting busy state');
    setBusy(true);
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
        if (e.response!.statusCode == 400) {
          errorMessage = 'Email already exists';
        } else if (e.response!.statusCode == 401) {
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
      setBusy(false);
    }
  }

  void navigateToLogin() {
    _navigationService.navigateTo(Routes.loginView);
  }

  // @override
  // void setBusy(bool value) {
  //   log.i('Setting busy state: $value');
  //   _utilsService.initiateLoading(value);
  //   super.setBusy(value);
  //   notifyListeners();
  // }

  void goBack() {
    _navigationService.back();
  }

  @override
  void dispose() {
    fullNameController.removeListener(_onTextChanged);
    emailController.removeListener(_onTextChanged);
    passwordController.removeListener(_onTextChanged);
    confirmPasswordController.removeListener(_onTextChanged);
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}