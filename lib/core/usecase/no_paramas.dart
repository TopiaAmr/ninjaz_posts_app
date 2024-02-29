import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// An empty class representing the absence of parameters.
///
/// Useful when a use case doesn't require any parameters.
@immutable
class NoParams extends Equatable {
  /// Creates a new [NoParams].
  const NoParams();

  @override
  List<Object?> get props => [];
}
