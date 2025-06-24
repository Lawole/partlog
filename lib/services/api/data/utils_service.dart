import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../ui/widgets/loading_indicator.dart';

class UtilsService {

  // void initiateLoading(bool value) {
  //   // TODO: implement setBusy
  //   if (value) {
  //     EasyLoading.show(
  //       maskType: EasyLoadingMaskType.custom,
  //       indicator: const LoadingIndicator(),
  //     );
  //     //notifyListeners();
  //   } else {
  //     EasyLoading.dismiss();
  //     // notifyListeners();
  //   }
  // }

  void initiateLoading(bool isLoading) {
    if (isLoading) {
      EasyLoading.show(
        status: 'Loading...',
        maskType: EasyLoadingMaskType.custom,
        dismissOnTap: false,
      );
    } else {
      EasyLoading.dismiss();
    }
  }

}
