import 'package:dartz/dartz.dart';

import 'package:ninjaz_posts_app/core/error/failure.dart';

/// An use case interface to execute a specific task.
///
/// The [call] method is the only one available and it's responsible
/// to execute the task. All the parameters related to the task should
/// be passed through [Params] generic type.
///
/// The [call] method returns an [Either] monad. If the task is successful,
/// [Either.right] will be returned with the result of the task. Otherwise, [Either.left]
/// will be returned with a [Failure] object representing the error.
abstract class BaseUseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}
