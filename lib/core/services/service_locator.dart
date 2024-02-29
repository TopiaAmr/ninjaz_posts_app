import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ninjaz_posts_app/core/network/api_consumer.dart';
import 'package:ninjaz_posts_app/core/network/dio_consumer.dart';
import 'package:ninjaz_posts_app/features/posts/data/datasrouce/posts_local_datasource.dart';
import 'package:ninjaz_posts_app/features/posts/data/datasrouce/posts_remote_datasource.dart';
import 'package:ninjaz_posts_app/features/posts/data/entities/post_entity.dart';
import 'package:ninjaz_posts_app/features/posts/data/repos/posts_repo.dart';
import 'package:ninjaz_posts_app/features/posts/domain/repository/posts_base_repo.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/get_post_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:realm/realm.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    /// Data Source
    getIt.registerLazySingleton<BasePostsRemoteDatasource>(
      () => PostsRemoteDatasource(getIt()),
    );
    getIt.registerLazySingleton<BasePostsLocalDatasource>(
      () => PostsLocalDatasource(getIt()),
    );

    ///Repositories
    getIt.registerLazySingleton<PostsBaseRepo>(() => PostsRepo(
          getIt(),
          getIt(),
        ));

    ///UseCases
    getIt.registerLazySingleton<GetPostUsecase>(
      () => GetPostUsecase(getIt()),
    );
    getIt.registerLazySingleton<GetPostsUsecase>(
      () => GetPostsUsecase(getIt()),
    );

    /// Blocs
    getIt.registerLazySingleton(
      () => PostsBloc(
        getIt(),
        getIt(),
      ),
    );

    ///Services
    getIt.registerLazySingleton<ApiConsumer>(
      () => DioConsumer(client: getIt()),
    );

    final config = Configuration.local([PostEntity.schema, OwnerEntity.schema]);
    getIt.registerLazySingleton<Realm>(() => Realm(config));
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
