import 'package:get_it/get_it.dart';
import 'package:sofra/core/network/api_service.dart';
import 'package:sofra/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:sofra/features/auth/domain/repositories/auth_repository.dart';
import 'package:sofra/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:sofra/features/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;
void initServiceLocator() {
  sl.registerFactory(() => AuthCubit(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton(() => ApiService());
}
