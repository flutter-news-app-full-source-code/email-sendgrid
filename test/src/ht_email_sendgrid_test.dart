// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:ht_email_sendgrid/ht_email_sendgrid.dart';
import 'package:test/test.dart';

void main() {
  group('HtEmailSendgrid', () {
    test('can be instantiated', () {
      expect(HtEmailSendgrid(), isNotNull);
    });
  });
}
