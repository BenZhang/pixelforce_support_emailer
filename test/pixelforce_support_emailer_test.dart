import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:pixelforce_support_emailer/pixelforce_support_emailer.dart';

void main() {
  testWidgets('Support Email', (WidgetTester tester) async {
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          final supportEmailer = PixelSupportMailer('33');
          supportEmailer.sendSupportEmail('test@test.com', 'Support', context);

          // The builder function must return a widget.
          return Placeholder();
        },
      ),
    );
  });
}
