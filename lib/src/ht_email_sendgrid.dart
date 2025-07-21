import 'package:ht_email_client/ht_email_client.dart';
import 'package:ht_http_client/ht_http_client.dart';
import 'package:ht_shared/ht_shared.dart';
import 'package:logging/logging.dart';

/// {@template ht_email_sendgrid}
/// A client for sending emails using the SendGrid API.
///
/// This class implements the [HtEmailClient] interface and uses an
/// [HtHttpClient] to communicate with the SendGrid v3 API.
/// {@endtemplate}
class HtEmailSendGrid implements HtEmailClient {
  /// {@macro ht_email_sendgrid}
  ///
  /// Requires a pre-configured [HtHttpClient] instance that includes the
  /// SendGrid API base URL ('https://api.sendgrid.com/v3') and an
  /// authentication interceptor to provide the SendGrid API key as a
  /// Bearer token.
  const HtEmailSendGrid({
    required HtHttpClient httpClient,
    required Logger log,
  }) : _httpClient = httpClient,
       _log = log;

  final HtHttpClient _httpClient;
  final Logger _log;

  static const String _sendPath = '/mail/send';

  @override
  Future<void> sendTransactionalEmail({
    required String recipientEmail,
    required String templateId,
    required Map<String, dynamic> templateData,
  }) async {
    _log.info(
      'Attempting to send email to $recipientEmail with template $templateId',
    );

    // Construct the payload according to the SendGrid v3 API specification.
    final payload = {
      'personalizations': [
        {
          'to': [
            {'email': recipientEmail},
          ],
          'dynamic_template_data': templateData,
        },
      ],
      'from': {
        'email': 'noreply@example.com', // This should be a configured sender
      },
      'template_id': templateId,
    };

    try {
      // The HtHttpClient's post method will handle the request and its
      // ErrorInterceptor will map DioExceptions to HtHttpExceptions.
      await _httpClient.post<void>(_sendPath, data: payload);
      _log.info(
        'Successfully requested email send to $recipientEmail with template $templateId',
      );
    } on HtHttpException {
      // Re-throw the already mapped exception for the repository/service
      // layer to handle.
      rethrow;
    } catch (e, s) {
      // Catch any other unexpected errors.
      _log.severe(
        'An unexpected error occurred while sending email via SendGrid.',
        e,
        s,
      );
      throw OperationFailedException(
        'An unexpected error occurred: $e',
      );
    }
  }
}
