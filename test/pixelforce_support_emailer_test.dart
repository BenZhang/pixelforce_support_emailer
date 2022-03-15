import 'package:flutter_test/flutter_test.dart';

import 'package:pixelforce_support_emailer/pixelforce_support_emailer.dart';

void main() {
  test('should load Email', () {
    final supportEmailer = PixelSupportMailer('33');
    supportEmailer.sendSupportEmail('test@test.com');
  });
}
