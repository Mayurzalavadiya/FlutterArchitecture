import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:my_first_app/data/model/response/get_cart_data.dart';
import 'package:my_first_app/data/model/response/get_quotes_response.dart';
import 'package:my_first_app/data/model/response/login_response.dart';
import 'package:my_first_app/ui/home/store/home_store.dart';
import 'package:my_first_app/ui/quotes/store/quotes_store.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/model/response/user_profile_response.dart';
import '../../data/repository_impl/auth_repo_impl.dart';
import '../../router/app_router.dart';
import '../../ui/auth/store/auth_store.dart';
import '../../utils/social_login.dart';
import '../api/api_module.dart';
import '../db/app_db.dart';
import '../db/share_pref.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  /// setup hive
  final appDocumentDir = Platform.isAndroid
      ? await getApplicationDocumentsDirectory()
      : await getLibraryDirectory();

  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(UserDataAdapter());
  Hive.registerAdapter(LoginResponseAdapter());
  Hive.registerAdapter(ProductsAdapter());
  Hive.registerAdapter(QuotesAdapter());

  locator.registerSingletonAsync<AppDB>(() => AppDB.getInstance());

  locator.registerSingletonAsync<AppPreferences>(() => AppPreferences.getInstance());

  /// setup API modules with repos which requires [Dio] instance
  await ApiModule().provides();

  /// setup encryption service
  // locator.registerLazySingleton(
  //   () => EncService(aesKey: "WQXy4CzZyUyJNOr5z5mvcR13dwxBGKnr"),
  // );
  /// setup navigator instance
  locator.registerSingleton(AppRouter());

  /// register repositories implementation
  locator.registerFactory<AuthRepoImpl>(() => AuthRepoImpl(authApi: locator()));

  // register stores if only you requires singleton
  locator.registerLazySingleton<AuthStore>(() => AuthStore());
  locator.registerLazySingleton<HomeStore>(() => HomeStore());
  locator.registerLazySingleton<QuotesStore>(() => QuotesStore());

  /// ✅ register social login service
  locator.registerLazySingleton<SocialLogin>(() => SocialLogin());
}
