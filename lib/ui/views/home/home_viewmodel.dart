// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';
//
// import '../../../app/app.bottomsheets.dart';
// import '../../../app/app.dialogs.dart';
// import '../../../app/app.locator.dart';
// import '../../common/app_strings.dart';
//
// class HomeViewModel extends BaseViewModel {
//   final _dialogService = locator<DialogService>();
//   final _bottomSheetService = locator<BottomSheetService>();
//
//   String get counterLabel => 'Counter is: $_counter';
//
//   int _counter = 0;
//
//   void incrementCounter() {
//     _counter++;
//     rebuildUi();
//   }
//
//   void showDialog() {
//     _dialogService.showCustomDialog(
//       variant: DialogType.infoAlert,
//       title: 'Stacked Rocks!',
//       description: 'Give stacked $_counter stars on Github',
//     );
//   }
//
//   void showBottomSheet() {
//     _bottomSheetService.showCustomSheet(
//       variant: BottomSheetType.notice,
//       title: ksHomeBottomSheetTitle,
//       description: ksHomeBottomSheetDescription,
//     );
//   }
// }

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
