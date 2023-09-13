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

import '../core/platform/network_info.dart' as _i10;
import '../core/services/mock_reader_service.dart' as _i9;
import '../data/repositories/auth_repository/auth_repository.dart' as _i12;
import '../data/repositories/auth_repository/data_sources/auth_firebase_repository.dart'
    as _i4;
import '../data/repositories/auth_repository/data_sources/auth_mock_repository.dart'
    as _i5;
import '../data/repositories/user_repository/data_sources/user_firebase_repository.dart'
    as _i7;
import '../data/repositories/user_repository/data_sources/user_mock_repository.dart'
    as _i8;
import '../data/repositories/user_repository/user_repository.dart' as _i15;
import '../domain/repositories/auth_repository/data_sources/ilocal_repository.dart'
    as _i13;
import '../domain/repositories/auth_repository/data_sources/iremote_repository.dart'
    as _i3;
import '../domain/repositories/auth_repository/i_auth_repository.dart' as _i11;
import '../domain/repositories/user_repository/data_sources/ilocal_repository.dart'
    as _i16;
import '../domain/repositories/user_repository/data_sources/iremote_repository.dart'
    as _i6;
import '../domain/repositories/user_repository/i_auth_repository.dart' as _i14;

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
  gh.lazySingleton<_i6.IUserRemoteRepository>(
    () => _i7.UserFirebaseRepository(),
    registerFor: {_real},
  );
  gh.lazySingleton<_i6.IUserRemoteRepository>(
    () => _i8.UserMockRepository(),
    registerFor: {_mock},
  );
  gh.lazySingleton<_i9.MockReaderService>(() => _i9.MockReaderService());
  gh.lazySingleton<_i10.NetworkInfo>(() => _i10.NetworkInfoImpl());
  gh.lazySingleton<_i11.IAuthRepository>(() => _i12.AuthRepository(
        remoteDataSource: gh<_i3.IAuthRemoteRepository>(),
        localDataSource: gh<_i13.IAuthLocalRepository>(),
        networkInfo: gh<_i10.NetworkInfo>(),
      ));
  gh.lazySingleton<_i14.IUserRepository>(() => _i15.UserRepository(
        remoteDataSource: gh<_i6.IUserRemoteRepository>(),
        localDataSource: gh<_i16.IUserLocalRepository>(),
        networkInfo: gh<_i10.NetworkInfo>(),
      ));
  return getIt;
}
