// ignore: lines_longer_than_80_chars
// ignore_for_file: avoid_dynamic_calls, inference_failure_on_function_invocation,

import 'package:core/core.dart';
import 'package:email_sendgrid/email_sendgrid.dart';
import 'package:http_client/http_client.dart';
import 'package:logging/logging.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  group('EmailSendGrid', () {
    late HttpClient mockHttpClient;
    late EmailSendGrid emailClient;

    const senderEmail = 'sender@example.com';
    const recipientEmail = 'test@example.com';
    const templateId = 'd-12345';
    const templateData = {'name': 'Test User'};

    setUp(() {
      mockHttpClient = MockHttpClient();
      emailClient = EmailSendGrid(
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
          () => mockHttpClient.post<void>(any(), data: any(named: 'data')),
        ).thenAnswer((_) async => Future.value());

        // Act
        await emailClient.sendTransactionalEmail(
          senderEmail: senderEmail,
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
        expect(payload['from']['email'], senderEmail);
        final personalizations =
            payload['personalizations'] as List<Map<String, dynamic>>;
        expect(personalizations.first['to'].first['email'], recipientEmail);
        expect(personalizations.first['dynamic_template_data'], templateData);
      });

      test('propagates HttpException from http client', () async {
        // Arrange
        const exception = ServerException('Failed');
        when(
          () => mockHttpClient.post<void>(any(), data: any(named: 'data')),
        ).thenThrow(exception);

        // Act & Assert
        expect(
          () => emailClient.sendTransactionalEmail(
            senderEmail: senderEmail,
            recipientEmail: recipientEmail,
            templateId: templateId,
            templateData: templateData,
          ),
          throwsA(isA<HttpException>()),
        );
      });

      test('throws OperationFailedException on unexpected error', () async {
        // Arrange
        final exception = Exception('Unexpected error');
        when(
          () => mockHttpClient.post<void>(any(), data: any(named: 'data')),
        ).thenThrow(exception);

        // Act & Assert
        expect(
          () => emailClient.sendTransactionalEmail(
            senderEmail: senderEmail,
            recipientEmail: recipientEmail,
            templateId: templateId,
            templateData: templateData,
          ),
          throwsA(isA<OperationFailedException>()),
        );
      });
    });
  });
}
