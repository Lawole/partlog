import 'package:flutter/cupertino.dart';
import 'package:flutter_dojah_kyc/flutter_dojah_kyc.dart';
import 'package:stacked/stacked.dart';

class DojahKycViewModel extends BaseViewModel {
  final String appId = "6793943eab804ca5b9514d58";
  final String publicKey = "test_pk_Ut7XVwNCKWFBxiKhvOjgxToZw";

  void openDojahWidget(BuildContext context) {
    final configObj = {"widget_id": "67942a0eab804ca5b993a865"};

    final userData = {
      "first_name": "Olawole",
      "last_name": "Dosunmu",
      "dob": "1901-01-01",
      "email": "olawoledosunmu@gmail.com"
    };

    final metaData = {
      "user_id": "olawole",
    };

    // final govData = {
    //   "bvn": "",
    //   "nin": "",
    //   "dl": "",
    //   "mobile": ""
    // };

    DojahKYC? _dojahKYC;

    _dojahKYC = DojahKYC(
        appId: appId,
        publicKey: publicKey,
        type: "custom",
        metaData: metaData,
        config: configObj,
        // govData: govData,
        userData: userData);

    _dojahKYC.open(
      context,
      onSuccess: (result) {
        print("Dojah Success: $result");
      },
      onClose: (close) {
        print("Widget Closed");
      },
      onError: (error) {
        print("Dojah Error: $error");
      },
    );
  }
}
