// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/platform/network_info.dart' as _i14;
import '../core/services/like_service.dart' as _i12;
import '../core/services/mock_reader_service.dart' as _i13;
import '../core/services/saved_post_service.dart' as _i15;
import '../core/services/user_service.dart' as _i16;
import '../data/repositories/auth_repository/auth_repository.dart' as _i18;
import '../data/repositories/auth_repository/data_sources/auth_firebase_repository.dart'
    as _i4;
import '../data/repositories/auth_repository/data_sources/auth_mock_repository.dart'
    as _i5;
import '../data/repositories/post_repository/data_sources/post_firebase_repository.dart'
    as _i8;
import '../data/repositories/post_repository/data_sources/post_mock_repository.dart'
    as _i7;
import '../data/repositories/post_repository/post_repository.dart' as _i21;
import '../data/repositories/user_repository/data_sources/user_firebase_repository.dart'
    as _i10;
import '../data/repositories/user_repository/data_sources/user_mock_repository.dart'
    as _i11;
import '../data/repositories/user_repository/user_repository.dart' as _i24;
import '../domain/repositories/auth_repository/data_sources/ilocal_repository.dart'
    as _i19;
import '../domain/repositories/auth_repository/data_sources/iremote_repository.dart'
    as _i3;
import '../domain/repositories/auth_repository/i_auth_repository.dart' as _i17;
import '../domain/repositories/post_repository/data_sources/ilocal_repository.dart'
    as _i22;
import '../domain/repositories/post_repository/data_sources/iremote_repository.dart'
    as _i6;
import '../domain/repositories/post_repository/i_post_repository.dart' as _i20;
import '../domain/repositories/user_repository/data_sources/ilocal_repository.dart'
    as _i25;
import '../domain/repositories/user_repository/data_sources/iremote_repository.dart'
    as _i9;
import '../domain/repositories/user_repository/i_auth_repository.dart' as _i23;

const String _real = 'real';
const String _mock = 'mock';

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.IAuthRemoteRepository>(
    () => _i4.AuthFirebaseRepository(),
    registerFor: {_real},
  );
  gh.lazySingleton<_i3.IAuthRemoteRepository>(
    () => _i5.AuthMockRepository(),
    registerFor: {_mock},
  );
  gh.lazySingleton<_i6.IPostRemoteRepository>(
    () => _i7.PostMockRepository(),
    registerFor: {_mock},
  );
  gh.lazySingleton<_i6.IPostRemoteRepository>(
    () => _i8.PostFirebaseRepository(),
    registerFor: {_real},
  );
  gh.lazySingleton<_i9.IUserRemoteRepository>(
    () => _i10.UserFirebaseRepository(),
    registerFor: {_real},
  );
  gh.lazySingleton<_i9.IUserRemoteRepository>(
    () => _i11.UserMockRepository(),
    registerFor: {_mock},
  );
  gh.lazySingleton<_i12.LikeService>(() => _i12.LikeService());
  gh.lazySingleton<_i13.MockReaderService>(() => _i13.MockReaderService());
  gh.lazySingleton<_i14.NetworkInfo>(() => _i14.NetworkInfoImpl());
  gh.lazySingleton<_i15.SavedPostService>(() => _i15.SavedPostService());
  gh.lazySingleton<_i16.UserService>(() => _i16.UserService());
  gh.lazySingleton<_i17.IAuthRepository>(() => _i18.AuthRepository(
        remoteDataSource: gh<_i3.IAuthRemoteRepository>(),
        localDataSource: gh<_i19.IAuthLocalRepository>(),
        networkInfo: gh<_i14.NetworkInfo>(),
      ));
  gh.lazySingleton<_i20.IPostRepository>(() => _i21.PostRepository(
        remoteDataSource: gh<_i6.IPostRemoteRepository>(),
        localDataSource: gh<_i22.IPostLocalRepository>(),
        networkInfo: gh<_i14.NetworkInfo>(),
      ));
  gh.lazySingleton<_i23.IUserRepository>(() => _i24.UserRepository(
        remoteDataSource: gh<_i9.IUserRemoteRepository>(),
        localDataSource: gh<_i25.IUserLocalRepository>(),
        networkInfo: gh<_i14.NetworkInfo>(),
      ));
  return getIt;
}
