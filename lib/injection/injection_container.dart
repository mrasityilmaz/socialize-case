import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:my_coding_setup/core/extensions/list_extension.dart';
import 'package:my_coding_setup/data/repositories/auth_repository/data_sources/auth_hive_repository.dart';
import 'package:my_coding_setup/data/repositories/post_repository/data_sources/post_hive_repository.dart';
import 'package:my_coding_setup/data/repositories/user_repository/data_sources/user_hive_repository.dart';
import 'package:my_coding_setup/domain/repositories/auth_repository/data_sources/ilocal_repository.dart';
import 'package:my_coding_setup/domain/repositories/post_repository/data_sources/ilocal_repository.dart';
import 'package:my_coding_setup/domain/repositories/user_repository/data_sources/ilocal_repository.dart';
import 'package:my_coding_setup/injection/injection_container.config.dart';

final locator = GetIt.instance;
late final DataType environmentTag;

enum DataType {
  real,
  mock,
}

@InjectableInit(
  generateForDir: [
    'lib',
    'test',
  ],
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> configureDependencies({String? defaultEnv}) async {
  if (defaultEnv == null) {
    const data = String.fromEnvironment('DATA_TYPE');
    environmentTag = DataType.values.firstWhereOrDefault((element) => element.name == data, defaultValue: DataType.mock);
  } else {
    environmentTag = DataType.values.firstWhereOrDefault((element) => element.name == defaultEnv, defaultValue: DataType.mock);
  }

  ///
  /// Register all local repositories
  ///
  /// You have to register all local repositories here.
  ///
  await _initSource<IAuthLocalRepository>(source: AuthHiveRepository());
  await _initSource<IUserLocalRepository>(source: UserHiveRepository());
  await _initSource<IPostLocalRepository>(source: PostHiveRepository());

  $initGetIt(
    locator,
    environment: environmentTag.name,
  );
}

///
/// Register all sources
///
Future<void> _initSource<T extends Object>({required T source}) async {
  // await source.init();
  locator.registerLazySingleton<T>(
    () => source,
  );
}
