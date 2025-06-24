import 'package:flutter_test/flutter_test.dart';
import 'package:dojah_kyc/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('DojahKycViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
