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
    if (!isFormValid || !_isChecked) {
      Fluttertoast.showToast(
        msg: !_isChecked
            ? 'You must agree to the Terms of Use and Privacy Policy'
            : 'Please ensure all fields are valid',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIosWeb: 3,
      );
      _showCheckboxError = !_isChecked;
      notifyListeners();
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
        await _navigationService.clearStackAndShow(
          Routes.homeView,
          arguments: {'token': user.token},
        );
      }
    } catch (e) {
      String errorMessage = 'Registration failed';
      if (e is DioException && e.response != null) {
        final code = e.response!.statusCode;
        final data = e.response!.data;
        if (code == 400) {
          errorMessage = 'Email already exists';
        } else if (code == 401) {
          errorMessage = 'Unauthorized: Invalid credentials';
        } else if (data['error'] != null) {
          errorMessage = data['error'];
        } else {
          errorMessage = 'Error: $code - $data';
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
