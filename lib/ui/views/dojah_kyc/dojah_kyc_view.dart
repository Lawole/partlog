import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'dojah_kyc_viewmodel.dart';

class DojahKycView extends StackedView<DojahKycViewModel> {
  const DojahKycView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DojahKycViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: ElevatedButton(
              onPressed: () => viewModel.openDojahWidget(context),
              child: const Text("Start KYC Verification")),
        ),
      ),
    );
  }

  @override
  DojahKycViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DojahKycViewModel();
}
