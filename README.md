<div align="center">
  <img src="https://avatars.githubusercontent.com/u/202675624?s=400&u=dc72a2b53e8158956a3b672f8e52e39394b6b610&v=4" alt="Flutter News App Toolkit Logo" width="220">
  <h1>Email SendGrid</h1>
  <p><strong>A concrete implementation of the `EmailClient` interface using the SendGrid API for the Flutter News App Toolkit.</strong></p>
</div>

<p align="center">
  <img src="https://img.shields.io/badge/coverage-100%25-green?style=for-the-badge" alt="coverage">
  <a href="https://flutter-news-app-full-source-code.github.io/docs/"><img src="https://img.shields.io/badge/LIVE_DOCS-VIEW-slategray?style=for-the-badge" alt="Live Docs: View"></a>
  <a href="https://github.com/flutter-news-app-full-source-code"><img src="https://img.shields.io/badge/MAIN_PROJECT-BROWSE-purple?style=for-the-badge" alt="Main Project: Browse"></a>
</p>

This `email_sendgrid` package provides a concrete implementation of the `EmailClient` interface within the [**Flutter News App Full Source Code Toolkit**](https://github.com/flutter-news-app-full-source-code). It leverages the SendGrid v3 API to send transactional emails, offering a robust and reliable solution for email dispatch. Designed to be used with the `email_repository` and `http_client` packages, it utilizes the standardized `HttpClient` for making HTTP requests and handling errors, ensuring consistent behavior and robust error management. This package is crucial for backend services that require integration with a powerful email service provider.

## ⭐ Feature Showcase: Reliable SendGrid Email Integration

This package offers a comprehensive set of features for integrating with the SendGrid API.

<details>
<summary><strong>🧱 Core Functionality</strong></summary>

### 🚀 `EmailClient` Implementation
- **`EmailSendGrid` Class:** A concrete implementation of the `EmailClient` interface, providing a standardized way to send emails via SendGrid.
- **SendGrid API Integration:** Connects directly to the SendGrid v3 API for sending transactional emails, ensuring reliable delivery.

### 🌐 Template-Based Email Sending
- **`sendTransactionalEmail` Method:** Supports sending emails using pre-defined SendGrid templates, allowing for dynamic content injection via `templateData`. This decouples email content and styling from application logic.

### 🛡️ Integrated Error Handling
- **`HttpClient` & `HttpException`:** Leverages the `http_client` package for underlying HTTP communication and propagates standardized `HttpException` errors (from `core`), ensuring consistent and predictable error management.

### 💉 Dependency Injection Ready
- **`HttpClient` Dependency:** Requires an instance of `HttpClient` (from the `http_client` package) configured with the SendGrid API base URL and API key, promoting loose coupling and testability.

> **💡 Your Advantage:** This package provides a robust and production-ready SendGrid integration for your email sending needs. It simplifies the process of sending transactional emails, leverages standardized error handling, and integrates seamlessly with the existing `http_client` and `email_client` architecture.

</details>

## 🔑 Licensing

This `email_sendgrid` package is an integral part of the [**Flutter News App Full Source Code Toolkit**](https://github.com/flutter-news-app-full-source-code). For comprehensive details regarding licensing, including trial and commercial options for the entire toolkit, please refer to the main toolkit organization page.
