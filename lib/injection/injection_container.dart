import 'package:dots/app/features/give_user/logic/repo/give_repo.dart';
import 'package:dots/app/features/offer_packages/logic/repo/offers.dart';
import 'package:geeks_service/geeks_service.dart';
import 'package:geeks_theme/geeks_theme.dart';
import 'package:get_it/get_it.dart';

import '../app/features/add_employee/logic/cubit/add_employee_cubit.dart';
import '../app/features/add_employee/logic/repo/add_employee_repo.dart';
import '../app/features/auth/logic/blocs/login_bloc/login_bloc.dart';
import '../app/features/auth/logic/blocs/logout_cubit/logout_cubit.dart';
import '../app/features/auth/logic/repo/auth_repo.dart';
import '../app/features/give_meal/logic/cubit/give_meal_cubit.dart';
import '../app/features/give_meal/logic/repo/give_meal_repo.dart';
import '../app/features/give_user/logic/cubit/give_user_cubit.dart';
import '../app/features/home/logic/cubit/home_cubit.dart';
import '../app/features/home/logic/repo/slider_repo.dart';

import '../app/features/invoice/logic/cubit/invoice_cubit.dart';
import '../app/features/invoice/logic/repo/invoices.dart';
import '../app/features/notifications/logic/notifications_cubit/notifications_cubit.dart';
import '../app/features/notifications/logic/repo/notifications_repo.dart';
import '../app/features/offer_packages/logic/cubit/offers_list_cubit.dart';
import '../app/features/package/logic/cubit/cashback_offer_cubit.dart';
import '../app/features/package/logic/repo/cashback_repo.dart';
import '../app/features/static_pages/logic/repo/static_pages_repo.dart';
import '../app/features/static_pages/logic/static_pages_cubit/static_pages_cubit.dart';
import '../core/network/api_urls.dart';
import '../core/network/network_service.dart';
import '../core/theme/theme_app.dart';

final injector = GetIt.instance;

class InjectorFile {
  Future<void> injectorFile() async {
    _coreApp;
    _service;
    _offers;
    _auth;
    _invoices;
    _cashbackOffer;
    // _service;
    _giveUser;
    _staticPages;
    _addEmployee;
    _home;
    giveMeal;
    _notification;
  }
}

// Service
void get _service async {
  Dio dioFactory = await DioFactory(Dio()).createDio(
    ApiUrls.baseUrlApi,
    ApiUrls.keyHeaderToken,
    injector<FlutterSecureStorage>(),
  );
  injector.registerSingleton<Dio>(dioFactory);
  injector
      .registerSingleton<NetworkService>(NetworkServiceImpl(injector<Dio>()));
}

// App theme
void get _coreApp {
  injector.registerSingleton<GeeksTheme>(CustomThemeApp.appTheme);
  injector.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
}

void get _offers {
  injector.registerLazySingleton<OffersRepo>(
      () => OffersRepoImpl(injector<NetworkService>()));
  injector.registerFactory<OffersListCubit>(
      () => OffersListCubit(injector<OffersRepo>()));
}

void get giveMeal {
  injector.registerLazySingleton<GiveMealRepo>(
      () => GiveMealRepoImpl(injector<NetworkService>()));
  injector.registerFactory<GiveMealCubit>(
      () => GiveMealCubit(injector<GiveMealRepo>()));
}

void get _home {
  injector.registerLazySingleton<SliderHomeRepo>(
      () => SliderHomeImpl(injector<NetworkService>()));
  injector
      .registerFactory<HomeCubit>(() => HomeCubit(injector<SliderHomeRepo>()));
}

void get _addEmployee {
  injector.registerLazySingleton<EmployeeRepo>(
      () => EmployeeRepoImpl(injector<NetworkService>()));
  injector.registerFactory<EmployeeCubit>(
      () => EmployeeCubit(injector<EmployeeRepo>()));
}

//* ( Static Pages ) ...
void get _staticPages {
  injector.registerLazySingleton<StaticPagesRepo>(
    () => StaticPagesRepoImpl(injector<NetworkService>()),
  );

  injector.registerFactory<StaticPagesCubit>(
    () => StaticPagesCubit(injector<StaticPagesRepo>()),
  );
}

//* ( notification ) ...
void get _notification {
  injector.registerLazySingleton<NotificationsRepo>(
    () => NotificationsRepoImpl(injector<NetworkService>()),
  );

  injector.registerFactory<NotificationsCubit>(
    () => NotificationsCubit(injector<NotificationsRepo>()),
  );
}

void get _giveUser {
  injector.registerLazySingleton<GiveUserRepo>(
      () => GiveUserRepoImpl(injector<NetworkService>()));
  injector.registerFactory<GiveUserCubit>(
      () => GiveUserCubit(injector<GiveUserRepo>()));
}

void get _invoices {
  injector.registerLazySingleton<InvoicesRepo>(
      () => InvoicesRepoImpl(injector<NetworkService>()));
  injector.registerFactory<InvoiceCubit>(
      () => InvoiceCubit(injector<InvoicesRepo>()));
}

//* ( Auth ) ...
void get _auth {
  injector.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(injector<NetworkService>()),
  );

  injector.registerFactory<LoginBloc>(
    () => LoginBloc(injector<AuthRepo>()),
  );

  injector.registerFactory<LogoutCubit>(
    () => LogoutCubit(injector<AuthRepo>()),
  );
}

void get _cashbackOffer {
  injector.registerLazySingleton<CashbackOfferRepo>(
    () => CashbackOfferImpl(injector<NetworkService>()),
  );

  injector.registerFactory<CashbackOfferCubit>(
    () => CashbackOfferCubit(injector<CashbackOfferRepo>()),
  );
}
