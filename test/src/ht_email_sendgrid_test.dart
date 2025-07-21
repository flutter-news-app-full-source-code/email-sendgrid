import 'package:ht_email_sendgrid/ht_email_sendgrid.dart';
import 'package:ht_http_client/ht_http_client.dart';
import 'package:ht_shared/ht_shared.dart';
import 'package:logging/logging.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHtHttpClient extends Mock implements HtHttpClient {}

void main() {
  group('HtEmailSendGrid', () {
    late HtHttpClient mockHttpClient;
    late HtEmailSendGrid emailClient;

    const recipientEmail = 'test@example.com';
    const templateId = 'd-12345';
    const templateData = {'name': 'Test User'};

    setUp(() {
      mockHttpClient = MockHtHttpClient();
      emailClient = HtEmailSendGrid(
        httpClient: mockHttpClient,
        log: Logger('TestLogger'),
      );
    });

    test('can be instantiated', () {
      expect(emailClient, isNotNull);
    });

    group('sendTransactionalEmail', () {
      test('calls http client post with correct payload on success', () async {
        // Arrange
        when(
          () => mockHttpClient.post<void>(
            any(),
            data: any(named: 'data'),
          ),
        ).thenAnswer((_) async => Future.value());

        // Act
        await emailClient.sendTransactionalEmail(
          recipientEmail: recipientEmail,
          templateId: templateId,
          templateData: templateData,
        );

        // Assert
        final captured = verify(
          () => mockHttpClient.post<void>(
            '/mail/send',
            data: captureAny(named: 'data'),
          ),
        ).captured;

        final payload = captured.first as Map<String, dynamic>;
        expect(payload['template_id'], templateId);
        expect(payload['from']['email'], 'noreply@example.com');
        final personalizations =
            payload['personalizations'] as List<Map<String, dynamic>>;
        expect(personalizations.first['to'].first['email'], recipientEmail);
        expect(
          personalizations.first['dynamic_template_data'],
          templateData,
        );
      });

      test('propagates HtHttpException from http client', () async {
        // Arrange
        final exception = ServerException('Failed');
        when(
          () => mockHttpClient.post<void>(
            any(),
            data: any(named: 'data'),
          ),
        ).thenThrow(exception);

        // Act & Assert
        expect(
          () => emailClient.sendTransactionalEmail(
            recipientEmail: recipientEmail,
            templateId: templateId,
            templateData: templateData,
          ),
          throwsA(isA<HtHttpException>()),
        );
      });
    });
  });
}
