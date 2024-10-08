// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dawaa24/core/data/datasource/base_local_datasource.dart'
    as _i22;
import 'package:dawaa24/core/data/datasource/base_remote_datasource.dart'
    as _i16;
import 'package:dawaa24/core/data/datasource/theme_local_datasource.dart'
    as _i35;
import 'package:dawaa24/core/data/network/network_Info.dart' as _i25;
import 'package:dawaa24/core/data/repository/device_repository.dart' as _i5;
import 'package:dawaa24/core/data/repository/push_notification_repository.dart'
    as _i6;
import 'package:dawaa24/core/presentation/blocs/theme_bloc/theme_bloc.dart'
    as _i66;
import 'package:dawaa24/core/services/agora_service.dart' as _i8;
import 'package:dawaa24/core/services/local_authentication_biometrics_service.dart'
    as _i10;
import 'package:dawaa24/core/services/location_helper.dart' as _i3;
import 'package:dawaa24/core/services/notification_handler.dart' as _i7;
import 'package:dawaa24/core/services/share_service.dart' as _i9;
import 'package:dawaa24/core/utils/handler/auth_handler.dart' as _i4;
import 'package:dawaa24/di/modules/injectable_module.dart' as _i74;
import 'package:dawaa24/features/address/data/remote_datasource/address_remote_datasource.dart'
    as _i29;
import 'package:dawaa24/features/address/data/remote_datasource/address_remote_datasource_impl.dart'
    as _i30;
import 'package:dawaa24/features/address/data/repository/address_repository_impl.dart'
    as _i37;
import 'package:dawaa24/features/address/domain/repository/address_repository.dart'
    as _i36;
import 'package:dawaa24/features/address/domain/usecase/add_address_usecase.dart'
    as _i65;
import 'package:dawaa24/features/address/domain/usecase/delete_address_usecase.dart'
    as _i61;
import 'package:dawaa24/features/address/domain/usecase/get_address_usecase.dart'
    as _i62;
import 'package:dawaa24/features/address/domain/usecase/make_default_address_usecase.dart'
    as _i64;
import 'package:dawaa24/features/address/domain/usecase/update_address_usecase.dart'
    as _i63;
import 'package:dawaa24/features/auth/data/datasource/local_datasource/auth_local_datasource.dart'
    as _i28;
import 'package:dawaa24/features/auth/data/datasource/remote_datasource/auth_remote_datasource.dart'
    as _i31;
import 'package:dawaa24/features/auth/data/datasource/remote_datasource/auth_remote_datasource_impl.dart'
    as _i32;
import 'package:dawaa24/features/auth/data/repository/auth_repository_impl.dart'
    as _i39;
import 'package:dawaa24/features/auth/domain/repository/auth_repository.dart'
    as _i38;
import 'package:dawaa24/features/auth/domain/usecase/change_language_usecase.dart'
    as _i55;
import 'package:dawaa24/features/auth/domain/usecase/check_if_has_biometrics_usecase.dart'
    as _i21;
import 'package:dawaa24/features/auth/domain/usecase/get_countries_usecase.dart'
    as _i67;
import 'package:dawaa24/features/auth/domain/usecase/get_user_info_usecase.dart'
    as _i60;
import 'package:dawaa24/features/auth/domain/usecase/login_usecase.dart'
    as _i57;
import 'package:dawaa24/features/auth/domain/usecase/logout_usecase.dart'
    as _i58;
import 'package:dawaa24/features/auth/domain/usecase/resend_otp_usecase.dart'
    as _i54;
import 'package:dawaa24/features/auth/domain/usecase/update_patient_info_usecase.dart'
    as _i56;
import 'package:dawaa24/features/auth/domain/usecase/verify_otp_usecase.dart'
    as _i59;
import 'package:dawaa24/features/auth/presentation/cubits/authentication/authentication_cubit.dart'
    as _i15;
import 'package:dawaa24/features/chat/data/remote_datasource/chat_remote_datasource.dart'
    as _i19;
import 'package:dawaa24/features/chat/data/remote_datasource/chat_remote_datasource_impl.dart'
    as _i20;
import 'package:dawaa24/features/chat/data/repository/chat_repository_impl.dart'
    as _i53;
import 'package:dawaa24/features/chat/domain/repository/chat_repository.dart'
    as _i52;
import 'package:dawaa24/features/chat/domain/usecase/get_chat_token_usecase.dart'
    as _i69;
import 'package:dawaa24/features/chat/domain/usecase/get_suffix_usecase.dart'
    as _i68;
import 'package:dawaa24/features/chat/domain/usecase/get_user_id_usecase.dart'
    as _i70;
import 'package:dawaa24/features/main/presentation/cubits/main_page_cubit/main_page_cubit.dart'
    as _i11;
import 'package:dawaa24/features/notification/data/datasource/remote_datasource/notification_remote_datasource.dart'
    as _i17;
import 'package:dawaa24/features/notification/data/datasource/remote_datasource/notification_remote_datasource_impl.dart'
    as _i18;
import 'package:dawaa24/features/notification/data/repository/notification_repository_impl.dart'
    as _i27;
import 'package:dawaa24/features/notification/domain/repository/notification_repository.dart'
    as _i26;
import 'package:dawaa24/features/notification/domain/usecase/get_my_notifications_list_usecase.dart'
    as _i43;
import 'package:dawaa24/features/notification/domain/usecase/mark_notification_as_read_usecase.dart'
    as _i42;
import 'package:dawaa24/features/order/data/datasource/remote_datasource/order_remote_datasource.dart'
    as _i33;
import 'package:dawaa24/features/order/data/datasource/remote_datasource/order_remote_datasource_impl.dart'
    as _i34;
import 'package:dawaa24/features/order/data/repository/order_repository_impl.dart'
    as _i51;
import 'package:dawaa24/features/order/domain/repository/order_repository.dart'
    as _i50;
import 'package:dawaa24/features/order/domain/usecase/get_my_historic_order_usecase.dart'
    as _i71;
import 'package:dawaa24/features/order/domain/usecase/get_my_latest_order_usecase.dart'
    as _i72;
import 'package:dawaa24/features/order/domain/usecase/get_order_details_usecase.dart'
    as _i73;
import 'package:dawaa24/features/pharmacies/data/datasource/remote_datasource/pharmacies_remote_datasource.dart'
    as _i23;
import 'package:dawaa24/features/pharmacies/data/datasource/remote_datasource/pharmacies_remote_datasource_impl.dart'
    as _i24;
import 'package:dawaa24/features/pharmacies/data/repository/pharmacies_repository_impl.dart'
    as _i41;
import 'package:dawaa24/features/pharmacies/domain/repository/pharmacy_repository.dart'
    as _i40;
import 'package:dawaa24/features/pharmacies/domain/usecase/add_to_my_pharmacy_usecase.dart'
    as _i48;
import 'package:dawaa24/features/pharmacies/domain/usecase/archive_pharmacy_usecase.dart'
    as _i49;
import 'package:dawaa24/features/pharmacies/domain/usecase/get_archive_pharmacies_list_usecase.dart'
    as _i47;
import 'package:dawaa24/features/pharmacies/domain/usecase/get_pharmacies_list_usecase.dart'
    as _i46;
import 'package:dawaa24/features/pharmacies/domain/usecase/get_pharmacy_details_usecase.dart'
    as _i45;
import 'package:dawaa24/features/pharmacies/domain/usecase/scan_pharmacy_qr_usecase.dart'
    as _i44;
import 'package:dio/dio.dart' as _i14;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i12;
import 'package:shared_preferences/shared_preferences.dart' as _i13;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    gh.factory<_i3.LocationHelper>(() => _i3.LocationHelper());
    gh.singleton<_i4.AuthHandler>(() => _i4.AuthHandler());
    gh.singleton<_i5.DeviceRepository>(() => _i5.DeviceRepository());
    gh.singleton<_i6.PushNotificationRepository>(
        () => _i6.PushNotificationRepository());
    gh.singleton<_i7.NotificationHandler>(() => _i7.NotificationHandler());
    gh.singleton<_i8.AgoraService>(() => _i8.AgoraService());
    gh.singleton<_i9.ShareService>(() => _i9.ShareService());
    gh.singleton<_i10.LocalAuthenticationBiometricsService>(
        () => _i10.LocalAuthenticationBiometricsService());
    gh.lazySingleton<_i12.InternetConnectionChecker>(
        () => injectableModule.connectionChecker);
    await gh.lazySingletonAsync<_i13.SharedPreferences>(
      () => injectableModule.sharedPref,
      preResolve: true,
    );
    gh.lazySingleton<_i14.Dio>(() => injectableModule.dioInstance);
    gh.singleton<_i15.AuthenticationCubit>(
        () => _i15.AuthenticationCubit(gh<_i4.AuthHandler>()));
    gh.lazySingleton<_i16.BaseRemoteDataSourceImpl>(
        () => _i16.BaseRemoteDataSourceImpl(dio: gh<_i14.Dio>()));
    gh.singleton<_i17.NotificationRemoteDataSource>(
        () => _i18.NotificationDataSourceImpl(dio: gh<_i14.Dio>()));
    gh.singleton<_i19.ChatRemoteDataSource>(
        () => _i20.ChatDataSourceImpl(dio: gh<_i14.Dio>()));
    gh.factory<_i21.CheckIfHasBiometricsUseCase>(() =>
        _i21.CheckIfHasBiometricsUseCase(
            gh<_i10.LocalAuthenticationBiometricsService>()));
    gh.lazySingleton<_i22.BaseLocalDataSource>(
        () => _i22.BaseLocalDataSourceImp(gh<_i13.SharedPreferences>()));
    gh.singleton<_i23.PharmaciesRemoteDataSource>(
        () => _i24.PharmaciesDataSourceImpl(dio: gh<_i14.Dio>()));
    gh.lazySingleton<_i25.NetworkInfo>(
        () => _i25.NetworkInfoImpl(gh<_i12.InternetConnectionChecker>()));
    gh.singleton<_i26.NotificationRepository>(() =>
        _i27.NotificationRepositoryImpl(
            gh<_i17.NotificationRemoteDataSource>()));
    gh.lazySingleton<_i28.AuthLocalDataSource>(
        () => _i28.AuthLocalDataSourceImp(gh<_i13.SharedPreferences>()));
    gh.singleton<_i29.AddressRemoteDataSource>(
        () => _i30.AddressRemoteDataSourceImpl(dio: gh<_i14.Dio>()));
    gh.singleton<_i31.AuthRemoteDataSource>(
        () => _i32.AuthRemoteDataSourceImpl(dio: gh<_i14.Dio>()));
    gh.singleton<_i33.OrderRemoteDataSource>(
        () => _i34.OrderDataSourceImpl(dio: gh<_i14.Dio>()));
    gh.lazySingleton<_i35.ThemeLocalDataSource>(
        () => _i35.ThemeLocalDataSourceImpl(gh<_i13.SharedPreferences>()));
    gh.singleton<_i36.AddressRepository>(
        () => _i37.ReadingRepositoryImpl(gh<_i29.AddressRemoteDataSource>()));
    gh.singleton<_i38.AuthRepository>(() => _i39.AuthRepositoryImpl(
          gh<_i31.AuthRemoteDataSource>(),
          gh<_i28.AuthLocalDataSource>(),
          gh<_i4.AuthHandler>(),
          gh<_i6.PushNotificationRepository>(),
        ));
    gh.singleton<_i40.PharmaciesRepository>(() =>
        _i41.PharmaciesRepositoryImpl(gh<_i23.PharmaciesRemoteDataSource>()));
    gh.factory<_i42.MarkNotificationAsReadUseCase>(() =>
        _i42.MarkNotificationAsReadUseCase(
            repository: gh<_i26.NotificationRepository>()));
    gh.factory<_i43.GetMyNotificationListUseCase>(() =>
        _i43.GetMyNotificationListUseCase(
            repository: gh<_i26.NotificationRepository>()));
    gh.factory<_i44.ScanPharmacyQRUseCase>(() => _i44.ScanPharmacyQRUseCase(
        repository: gh<_i40.PharmaciesRepository>()));
    gh.factory<_i45.GetPharmacyDetailsUseCase>(() =>
        _i45.GetPharmacyDetailsUseCase(
            repository: gh<_i40.PharmaciesRepository>()));
    gh.factory<_i46.GetPharmaciesListUseCase>(() =>
        _i46.GetPharmaciesListUseCase(
            repository: gh<_i40.PharmaciesRepository>()));
    gh.factory<_i47.GetArchivePharmaciesListUseCase>(() =>
        _i47.GetArchivePharmaciesListUseCase(
            repository: gh<_i40.PharmaciesRepository>()));
    gh.factory<_i48.AddToMyPharmacyUseCase>(() => _i48.AddToMyPharmacyUseCase(
        repository: gh<_i40.PharmaciesRepository>()));
    gh.factory<_i49.ArchivePharmaciesUseCase>(() =>
        _i49.ArchivePharmaciesUseCase(
            repository: gh<_i40.PharmaciesRepository>()));
    gh.singleton<_i50.OrderRepository>(
        () => _i51.OrderRepositoryImpl(gh<_i33.OrderRemoteDataSource>()));
    gh.singleton<_i52.ChatRepository>(() => _i53.ChatRepositoryImpl(
          gh<_i19.ChatRemoteDataSource>(),
          gh<_i28.AuthLocalDataSource>(),
        ));
    gh.factory<_i54.ReSendOtpUseCase>(
        () => _i54.ReSendOtpUseCase(repository: gh<_i38.AuthRepository>()));
    gh.factory<_i55.ChangeLanguageUseCase>(() =>
        _i55.ChangeLanguageUseCase(repository: gh<_i38.AuthRepository>()));
    gh.factory<_i56.UpdatePatientInfoUseCase>(() =>
        _i56.UpdatePatientInfoUseCase(repository: gh<_i38.AuthRepository>()));
    gh.factory<_i57.LoginUseCase>(
        () => _i57.LoginUseCase(repository: gh<_i38.AuthRepository>()));
    gh.factory<_i58.LogOutUseCase>(
        () => _i58.LogOutUseCase(repository: gh<_i38.AuthRepository>()));
    gh.factory<_i59.VerifyOtpUseCase>(
        () => _i59.VerifyOtpUseCase(repository: gh<_i38.AuthRepository>()));
    gh.factory<_i60.GetUserInfoUseCase>(
        () => _i60.GetUserInfoUseCase(repository: gh<_i38.AuthRepository>()));
    gh.factory<_i61.DeleteAddressUseCase>(() =>
        _i61.DeleteAddressUseCase(repository: gh<_i36.AddressRepository>()));
    gh.factory<_i62.GetAddressListUseCase>(() =>
        _i62.GetAddressListUseCase(repository: gh<_i36.AddressRepository>()));
    gh.factory<_i63.UpdateAddressUseCase>(() =>
        _i63.UpdateAddressUseCase(repository: gh<_i36.AddressRepository>()));
    gh.factory<_i64.MakeAddressDefaultUseCase>(() =>
        _i64.MakeAddressDefaultUseCase(
            repository: gh<_i36.AddressRepository>()));
    gh.factory<_i65.AddAddressUseCase>(
        () => _i65.AddAddressUseCase(repository: gh<_i36.AddressRepository>()));
    gh.singleton<_i66.ThemeBloc>(() =>
        _i66.ThemeBloc(baseLocalDataSourcel: gh<_i35.ThemeLocalDataSource>()));
    gh.factory<_i67.GetCountriesUseCase>(
        () => _i67.GetCountriesUseCase(gh<_i38.AuthRepository>()));
    gh.factory<_i68.GetSuffixUseCase>(
        () => _i68.GetSuffixUseCase(repository: gh<_i52.ChatRepository>()));
    gh.factory<_i69.GetChatTokenUseCase>(
        () => _i69.GetChatTokenUseCase(repository: gh<_i52.ChatRepository>()));
    gh.factory<_i70.GetUserIdUseCase>(
        () => _i70.GetUserIdUseCase(repository: gh<_i52.ChatRepository>()));
    gh.factory<_i71.GetMyHistoricUseCase>(() =>
        _i71.GetMyHistoricUseCase(repository: gh<_i50.OrderRepository>()));
    gh.factory<_i72.GetMyLatestUseCase>(
        () => _i72.GetMyLatestUseCase(repository: gh<_i50.OrderRepository>()));
    gh.factory<_i73.GetOrderDetailsUseCase>(() =>
        _i73.GetOrderDetailsUseCase(repository: gh<_i50.OrderRepository>()));
    gh.singleton<_i11.MainPageCubit>(() => _i11.MainPageCubit());

    return this;
  }
}

class _$InjectableModule extends _i74.InjectableModule {}
