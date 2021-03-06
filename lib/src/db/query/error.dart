import 'query.dart';

/// An exception describing an issue with a query.
///
/// A suggested HTTP status code based on the type of exception will always be available.
class QueryException implements Exception {
  QueryException(this.event,
      {String message: null, this.underlyingException: null})
      : this._message = message;

  final String _message;

  /// The exception generated by the [PersistentStore] or other mechanism that caused [Query] to fail.
  final dynamic underlyingException;

  /// The type of event that caused this exception.
  final QueryExceptionEvent event;

  String toString() => _message ?? underlyingException.toString();
}

/// Categorizations of query failures for [QueryException].
enum QueryExceptionEvent {
  /// This event is used when the underlying [PersistentStore] reports that a unique constraint was violated.
  ///
  /// [RequestController]s interpret this exception to return a status code 409 by default.
  conflict,

  /// This event is used when the underlying [PersistentStore] reports an issue with the form of a [Query].
  ///
  /// [RequestController]s interpret this exception to return a status code 500 by default. This indicates
  /// to the programmer that the issue is with their code.
  internalFailure,

  /// This event is used when the underlying [PersistentStore] cannot reach its database.
  ///
  /// [RequestController]s interpret this exception to return a status code 503 by default.
  connectionFailure,

  /// This event is used when the underlying [PersistentStore] reports an issue with the data used in a [Query].
  ///
  /// [RequestController]s interpret this exception to return a status code 400 by default.
  requestFailure
}
