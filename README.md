# ht_email_sendgrid

![coverage: percentage](https://img.shields.io/badge/coverage-100-green)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)
[![License: PolyForm Free Trial](https://img.shields.io/badge/License-PolyForm%20Free%20Trial-blue)](https://polyformproject.org/licenses/free-trial/1.0.0)

A concrete implementation of the `HtEmailClient` interface that uses the SendGrid API to send transactional emails.

## Description

This package provides `HtEmailSendGrid`, a class that connects to the SendGrid v3 API to send emails. It is designed to be used with the `ht_email_repository` and `ht_http_client` packages, leveraging the standardized `HtHttpClient` for making HTTP requests and handling errors.

## Getting Started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  ht_email_sendgrid:
    git:
      url: https://github.com/headlines-toolkit/ht-email-sendgrid.git
      # ref: <specific_tag_or_commit>
```

## Usage

To use this client, you must first configure an `HtHttpClient` instance with the SendGrid API base URL and an `AuthInterceptor` that provides your SendGrid API key.

```dart
import 'package:dio/dio.dart';
import 'package:ht_email_client/ht_email_client.dart';
import 'package:ht_email_sendgrid/ht_email_sendgrid.dart';
import 'package:ht_http_client/ht_http_client.dart';
import 'package:logging/logging.dart';

void main() async {
  // 1. Configure the HtHttpClient for SendGrid
  final sendGridHttpClient = HtHttpClient(
    baseUrl: 'https://api.sendgrid.com/v3',
    tokenProvider: () async => 'YOUR_SENDGRID_API_KEY', // Provide your key here
    isWeb: false, // Use false for server-side applications
  );

  // 2. Instantiate the SendGrid email client
  final HtEmailClient emailClient = HtEmailSendGrid(
    httpClient: sendGridHttpClient,
    log: Logger('SendGridClient'),
  );

  // 3. Use the client to send an email
  try {
    await emailClient.sendTransactionalEmail(
      senderEmail: 'noreply@yourdomain.com',
      recipientEmail: 'recipient@example.com',
      templateId: 'd-your-template-id',
      templateData: {'name': 'World'},
    );
    print('Email sent successfully!');
  } on HtHttpException catch (e) {
    print('Failed to send email: $e');
  }
}
```

## License

This package is licensed under the [PolyForm Free Trial](LICENSE). Please review the terms before use.
