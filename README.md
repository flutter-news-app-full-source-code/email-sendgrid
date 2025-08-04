# email_sendgrid

![coverage: percentage](https://img.shields.io/badge/coverage-100-green)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)
[![License: PolyForm Free Trial](https://img.shields.io/badge/License-PolyForm%20Free%20Trial-blue)](https://polyformproject.org/licenses/free-trial/1.0.0)

A concrete implementation of the `EmailClient` interface that uses the SendGrid API to send transactional emails.

## Description

This package provides `EmailSendGrid`, a class that connects to the SendGrid v3 API to send emails. It is designed to be used with the `email_repository` and `http_client` packages, leveraging the standardized `HttpClient` for making HTTP requests and handling errors.

## Getting Started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  email_sendgrid:
    git:
      url: https://github.com/flutter-news-app-full-source-code/email-sendgrid.git
      # ref: <specific_tag_or_commit>
```

## Usage

To use this client, you must first configure an `HttpClient` instance with the SendGrid API base URL and an `AuthInterceptor` that provides your SendGrid API key.

```dart
import 'package:dio/dio.dart';
import 'package:email_client/email-client.dart';
import 'package:email_sendgrid/email_sendgrid.dart';
import 'package:http_client/http_client.dart';
import 'package:logging/logging.dart';

void main() async {
  // 1. Configure the HttpClient for SendGrid
  final sendGridHttpClient = HttpClient(
    baseUrl: 'https://api.sendgrid.com/v3',
    tokenProvider: () async => 'YOUR_SENDGRID_API_KEY', // Provide your key here
    isWeb: false, // Use false for server-side applications
  );

  // 2. Instantiate the SendGrid email client
  final EmailClient emailClient = EmailSendGrid(
    httpClient: sendGridHttpClient,
    log: Logger('SendGridClient'),
  );

  // 3. Use the client to send an email
  try {
    await emailClient.sendTransactionalEmail(
      senderEmail: 'noreply@yourdomain.com',
      recipientEmail: 'recipient@example.com',
      subject: 'Your Subject Here',
      templateId: 'd-your-template-id',
      templateData: {'name': 'World'},
    );
    print('Email sent successfully!');
  } on HttpException catch (e) {
    print('Failed to send email: $e');
  }
}
```


## 🔑 Licensing

This package is source-available and licensed under the [PolyForm Free Trial 1.0.0](LICENSE). Please review the terms before use.

For commercial licensing options that grant the right to build and distribute unlimited applications, please visit the main [**Flutter News App - Full Source Code Toolkit**](https://github.com/flutter-news-app-full-source-code) organization.
