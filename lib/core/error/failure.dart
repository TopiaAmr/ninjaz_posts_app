import 'package:equatable/equatable.dart';

/// Represents a failure.
///
/// This is the base class for all failures.
abstract class Failure extends Equatable {
  /// Creates a new [Failure] with the given [message].
  const Failure(this.message);

  /// The message associated with the failure.
  final String message;

  @override
  List<Object> get props => [message];
}

/// Represents a failure that occurred on the server.
class ServerFailure extends Failure {
  /// Creates a new [ServerFailure] with the given [message].
  const ServerFailure(super.message);
}

/// Represents a failure that occurred in the database.
class DatabaseFailure extends Failure {
  /// Creates a new [DatabaseFailure] with the given [message].
  const DatabaseFailure(super.message);
}
