
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../app/app.router.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final log = getLogger('HomeViewModel');

  void navigateToAnalytics() {
    log.i('Navigating to Analytics');
    // _navigationService.navigateTo(Routes.analyticsView);
  }

  void navigateToTasks() {
    log.i('Navigating to Tasks');
    // _navigationService.navigateTo(Routes.tasksView);
  }

  void navigateToProfile() {
    log.i('Navigating to Profile');
    // _navigationService.navigateTo(Routes.profileView);
  }

  void navigateToSettings() {
    log.i('Navigating to Settings');
    // _navigationService.navigateTo(Routes.settingsView);
  }

  void logout() {
    log.i('Logging out');
    _navigationService.clearStackAndShow(Routes.loginView);
  }
}
