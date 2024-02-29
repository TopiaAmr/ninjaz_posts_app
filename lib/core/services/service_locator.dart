import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ninjaz_posts_app/core/network/api_consumer.dart';
import 'package:ninjaz_posts_app/core/network/dio_consumer.dart';
import 'package:ninjaz_posts_app/features/posts/data/datasrouce/posts_remote_datasource.dart';
import 'package:ninjaz_posts_app/features/posts/data/repos/posts_repo.dart';
import 'package:ninjaz_posts_app/features/posts/domain/repository/posts_base_repo.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/get_post_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    /// Data Source
    getIt.registerLazySingleton<BasePostsRemoteDatasource>(
      () => PostsRemoteDatasource(getIt()),
    );

    ///Repositories
    getIt.registerLazySingleton<PostsBaseRepo>(() => PostsRepo(getIt()));

    ///UseCases
    getIt.registerLazySingleton<GetPostUsecase>(
      () => GetPostUsecase(getIt()),
    );
    getIt.registerLazySingleton<GetPostsUsecase>(
      () => GetPostsUsecase(getIt()),
    );

    ///Services
    getIt.registerLazySingleton<ApiConsumer>(
      () => DioConsumer(client: getIt()),
    );
    getIt.registerLazySingleton(() => Dio());
    getIt.registerLazySingleton(
      () => PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        logPrint: (object) {
          log(object.toString());
        },
      ),
    );
  }
}
