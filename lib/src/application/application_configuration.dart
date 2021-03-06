import 'dart:io';
import 'application.dart';
import '../http/request_sink.dart';

/// A set of values to configure an instance of [Application].
///
/// Instances of this type are configured by the command-line arguments for `aqueduct serve` and passed to [RequestSink] instances in their constructor.
/// Instances of this type are also passed to to a [RequestSink] subclass's `initializeApplication` method before it is instantiated. This allows
/// values to be modified prior to starting the server. See [RequestSink] for example usage.
class ApplicationConfiguration {
  /// Whether or not this application is being used to document an API.
  ///
  /// Defaults to false. If the application is being instantiated for the purpose of documenting the API,
  /// this flag will be true. This allows [RequestSink] subclasses to take a different initialization path
  /// when documenting vs. running the application.
  bool isDocumenting = false;

  /// The absolute path of the configuration file for this application.
  ///
  /// This value is used by [RequestSink] subclasses to read a configuration file. A [RequestSink] can choose
  /// to read values from this file at different initialization points. This value is set automatically
  /// when using `aqueduct serve`.
  String configurationFilePath;

  /// The address to listen for HTTP requests on.
  ///
  /// By default, this address will default to 'any' address (0.0.0.0). If [isIpv6Only] is true,
  /// 'any' will be any IPv6 address, otherwise, it will be any IPv4 or IPv6 address.
  ///
  /// This value may be an [InternetAddress] or a [String].
  dynamic address;

  /// The port to listen for HTTP requests on.
  ///
  /// Defaults to 8081.
  int port = 8081;

  /// Whether or not the application should only receive connections over IPv6.
  ///
  /// Defaults to false. This flag impacts the default value of the [address] property.
  bool isIpv6Only = false;

  /// Whether or not the application's request controllers should use client-side HTTPS certificates.
  ///
  /// Defaults to false.
  bool isUsingClientCertificate = false;

  /// Information for securing the application over HTTPS.
  ///
  /// Defaults to null. If this is null, this application will run unsecured over HTTP. To
  /// run securely over HTTPS, this property must be set with valid security details.
  SecurityContext securityContext = null;

  /// Options for each [RequestSink] to use when in this application.
  ///
  /// This is a user-specific set of configuration options. These values are typically set in [RequestSink]'s `initializeApplication`
  /// method so that each individual instance of [RequestSink] has actionable configuration options to use during their initialization.
  Map<String, dynamic> options = {};
}
