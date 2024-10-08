import 'package:dawaa24/core/data/enums/auth_state.dart';
import 'package:dawaa24/core/presentation/pages/no_internet_page.dart';
import 'package:dawaa24/features/address/data/model/address_model.dart';
import 'package:dawaa24/features/address/presentation/pages/add_address_page.dart';
import 'package:dawaa24/features/address/presentation/pages/address_list_page.dart';
import 'package:dawaa24/features/auth/presentation/cubits/quick_register_cubit/quick_register_cubit.dart';
import 'package:dawaa24/features/auth/presentation/pages/edit_profile/edit_profile_page.dart';
import 'package:dawaa24/features/auth/presentation/pages/quick_register_pages/otp_page.dart';
import 'package:dawaa24/features/auth/presentation/pages/quick_register_pages/select_gender_page.dart';
import 'package:dawaa24/features/auth/presentation/pages/welcome_page/welcome_page.dart';
import 'package:dawaa24/features/chat/presentation/pages/pharamcy_chat_list.dart';
import 'package:dawaa24/features/main/presentation/pages/main_page.dart';
import 'package:dawaa24/features/notification/presentation/pages/notification_list_page.dart';
import 'package:dawaa24/features/order/presentation/pages/order_details_page.dart';
import 'package:dawaa24/features/pharmacies/data/model/pharmacie_model.dart';
import 'package:dawaa24/features/pharmacies/presentation/pages/pharmacies_list_page.dart';
import 'package:dawaa24/features/pharmacies/presentation/pages/scan_qr_pharmacy_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'core/domain/params/no_auth_params.dart';
import 'core/domain/params/show_image_params.dart';
import 'core/domain/params/show_pdf_params.dart';
import 'core/presentation/pages/not_auth_page.dart';
import 'core/presentation/pages/show_image_page.dart';
import 'core/presentation/pages/show_pdf_page.dart';
import 'features/auth/presentation/pages/quick_register_pages/send_phone_number_page.dart';
import 'features/chat/domain/params/pharmacy_chat_page_params_model.dart';
import 'features/chat/presentation/pages/pharmacy_chat_page.dart';
import 'features/order/presentation/pages/orders_list/my_orders_main_page.dart';
import 'features/pharmacies/presentation/pages/main_pharmacies_page.dart';
import 'features/pharmacies/presentation/pages/pharmacy_details_page.dart';
import 'features/splash/presentation/pages/splash_pages/splash_page.dart';

abstract class AppPaths {
  static const splash = _SplashPaths();
  static const auth = _AuthPaths();
  static const pharmacies = _PharmaciesPaths();

  static const address = _AddressPaths();
  static const mainPaths = _MainPagesPaths();
  static const orderPaths = _OrderPagesPaths();
  static const chatPaths = _ChatPagesPaths();
  static const externalPaths = _ExternalPagesPaths();
}

class _SplashPaths {
  const _SplashPaths();

  String get splash => '/splash';

  String get noInternet => '/no_internet';
}

class _AuthPaths {
  const _AuthPaths();

  String get signIn => '/auth/SignIn';

  String get signUp => '/auth/SignUn';

  String get forgetPassword => '/auth/ForgetPassword';

  String get forgetPasswordOtp => 'Otp';

  String get passwordRecoveryUpdate => 'PasswordRecoveryUpdate';

  String get otpPage => '/auth/otp-page';

  String get selectGenderPage => '/auth/select-gender-page';

  String get changePasswordPage => '/auth/changePassword';

  String get noAuthPage => '/auth/noAuth';

  String get welcomePage => '/auth/welcome';

  String get editProfilePage => '/auth/edt_profile';
}

class _MainPagesPaths {
  const _MainPagesPaths();

  String get mainPage => '/mainPage';

  String get notificationPage => '/notificationPage';
}

class _PharmaciesPaths {
  const _PharmaciesPaths();

  String get myPharmacies => '/myPharmacies';

  String get pharmacies => '/pharmacies';

  String get pharmacyDetails => '/pharmacyDetails';

  String get scanQrPharmacy => '/scanQrPharmacy';
}

class _AddressPaths {
  const _AddressPaths();

  String get addressList => '/address/list';

  String get addNewAddress => '/address/add';
}

class _OrderPagesPaths {
  const _OrderPagesPaths();

  String get orderList => '/orders/list';

  String get orderDetails => '/orders/list/orderDetails';

  String get orderMainPage => '/orders/list/mainPage';
}

class _ChatPagesPaths {
  const _ChatPagesPaths();

  String get pharmacyChatPage => '/chat/pharmacy';

  String get pharmacyChatListPage => '/chat/pharmacy/list';
}

class _ExternalPagesPaths {
  const _ExternalPagesPaths();

  String get showImage => '/external/showImage';

  String get showPdf => '/external/showPdf';
}

GoRouter getRouter(AuthState authState) {
  String initialPath = '/';
  switch (authState) {
    case AuthState.unKnown:
      initialPath = AppPaths.splash.splash;
      break;
    case AuthState.authenticated:
      initialPath = AppPaths.mainPaths.mainPage;
      break;
    case AuthState.unAuthenticated:
      initialPath = AppPaths.auth.welcomePage;
      break;
    case AuthState.notVerified:
      initialPath = AppPaths.auth.selectGenderPage;
  }
  return GoRouter(
    initialLocation: initialPath,
    routes: <GoRoute>[
      GoRoute(
        path: AppPaths.splash.splash,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashPage(),
      ),
      GoRoute(
        path: AppPaths.splash.noInternet,
        builder: (BuildContext context, GoRouterState state) =>
            const NoInternetPage(),
      ),
      GoRoute(
          path: AppPaths.auth.noAuthPage,
          builder: (BuildContext context, GoRouterState state) {
            return NoAuthPage(
              noAuthParams: state.extra as NoAuthParams,
            );
          }),
      GoRoute(
          path: AppPaths.auth.welcomePage,
          builder: (BuildContext context, GoRouterState state) {
            return const WelcomePage();
          }),
      GoRoute(
          path: AppPaths.orderPaths.orderList,
          builder: (BuildContext context, GoRouterState state) {
            return const WelcomePage();
          }),
      GoRoute(
          path: AppPaths.orderPaths.orderDetails,
          builder: (BuildContext context, GoRouterState state) {
            return OrderDetailsPage(
              orderId: state.extra as String,
            );
          }),
      GoRoute(
          path: AppPaths.orderPaths.orderMainPage,
          builder: (BuildContext context, GoRouterState state) {
            return MyOrdersMainPage();
          }),
      GoRoute(
          path: AppPaths.auth.signIn,
          builder: (BuildContext context, GoRouterState state) {
            return const SendPhoneNumberPage();
          }),
      GoRoute(
        path: AppPaths.auth.otpPage,
        builder: (BuildContext context, GoRouterState state) => OtpPage(
          cubit: state.extra as QuickRegisterCubit,
        ),
      ),
      GoRoute(
          path: AppPaths.auth.editProfilePage,
          builder: (BuildContext context, GoRouterState state) {
            return const EditProfilePage();
          }),
      GoRoute(
          path: AppPaths.pharmacies.myPharmacies,
          builder: (BuildContext context, GoRouterState state) {
            return const PharmaciesListPage();
          }),
      GoRoute(
          path: AppPaths.pharmacies.pharmacies,
          builder: (BuildContext context, GoRouterState state) {
            return const MainPharmaciesPage();
          }),
      GoRoute(
          path: AppPaths.pharmacies.pharmacyDetails,
          builder: (BuildContext context, GoRouterState state) {
            if (state.extra is String) {
              return PharmacyDetailsPage(
                pharmacyModel: null,
                pharmacyId: state.extra as String,
              );
            } else {
              PharmacyModel model = state.extra as PharmacyModel;
              return PharmacyDetailsPage(
                pharmacyModel: model,
                isComingFromScanQR: model.isComingFromQr,
              );
            }
          }),
      GoRoute(
        path: AppPaths.address.addressList,
        builder: (BuildContext context, GoRouterState state) =>
            const AddressListPage(),
      ),
      GoRoute(
        path: AppPaths.address.addNewAddress,
        builder: (BuildContext context, GoRouterState state) => AddNewAddress(
          addressModel: state.extra as AddressModel?,
        ),
      ),
      GoRoute(
        path: AppPaths.mainPaths.mainPage,
        builder: (BuildContext context, GoRouterState state) => MainPage(),
      ),
      GoRoute(
        path: AppPaths.pharmacies.scanQrPharmacy,
        builder: (BuildContext context, GoRouterState state) =>
            const ScanQrPharmacyPage(),
      ),
      GoRoute(
        path: AppPaths.chatPaths.pharmacyChatPage,
        builder: (BuildContext context, GoRouterState state) =>
            PharmacyChatPage(
          pharmacyChatPageParamsModel:
              state.extra as PharmacyChatPageParamsModel,
        ),
      ),
      GoRoute(
        path: AppPaths.auth.selectGenderPage,
        builder: (BuildContext context, GoRouterState state) =>
            const SelectGenderPage(),
      ),
      GoRoute(
        path: AppPaths.externalPaths.showImage,
        builder: (BuildContext context, GoRouterState state) => ShowImagePage(
          params: state.extra as ShowImageParams,
        ),
      ),
      GoRoute(
        path: AppPaths.externalPaths.showPdf,
        builder: (BuildContext context, GoRouterState state) => ShowPdfPage(
          pdfParams: state.extra as ShowPdfParams,
        ),
      ),
      GoRoute(
        path: AppPaths.chatPaths.pharmacyChatListPage,
        builder: (BuildContext context, GoRouterState state) =>
            const PharmacyChatListPage(),
      ),
      GoRoute(
        path: AppPaths.mainPaths.notificationPage,
        builder: (BuildContext context, GoRouterState state) =>
            const NotificationListPage(),
      ),
    ],
  );
}
