import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "asset/lottie/loading_state.json",
      width: 65,
      height: 65,
      alignment: Alignment.center,
    );
  }
}
