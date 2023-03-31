// import 'package:CHATS_Vendor/core/constants/route_paths.dart';
// import 'package:CHATS_Vendor/modules/home/home_screen.dart';
// import 'package:CHATS_Vendor/modules/onboard/screens/login_screen.dart';
// import 'package:CHATS_Vendor/modules/onboard/screens/on_board.dart';
// import 'package:CHATS_Vendor/modules/splash/splash_screen.dart';
// import 'package:CHATS_Vendor/ui/screen/accept_payment_view.dart';
// import 'package:CHATS_Vendor/ui/screen/campaigns_view.dart';
// import 'package:CHATS_Vendor/ui/screen/payment_confirm_view.dart';
// import 'package:CHATS_Vendor/ui/screen/payments_create_view.dart';
// import 'package:CHATS_Vendor/ui/screen/payments_qrcode.dart';
// import 'package:CHATS_Vendor/ui/screen/payments_summary_view.dart';
// import 'package:CHATS_Vendor/ui/screen/profile/account.dart';
// import 'package:CHATS_Vendor/ui/screen/profile/change_password_view.dart';
// import 'package:CHATS_Vendor/ui/screen/profile/change_pin_view.dart';
// import 'package:CHATS_Vendor/ui/screen/profile/help_support_view.dart';
// import 'package:CHATS_Vendor/ui/screen/profile/kyc_status.dart';
// import 'package:CHATS_Vendor/ui/screen/profile/personal_info_view.dart';
// import 'package:CHATS_Vendor/ui/screen/profile/profile_view.dart';
// import 'package:CHATS_Vendor/ui/screen/profile/reset_password_view.dart';
// import 'package:CHATS_Vendor/ui/screen/profile/security_view.dart';
// import 'package:CHATS_Vendor/ui/screen/profile/set_pin_view.dart';
// import 'package:CHATS_Vendor/ui/screen/profile/settings_view.dart';
// import 'package:CHATS_Vendor/ui/screen/scan_code_view.dart';
// import 'package:CHATS_Vendor/ui/screen/sign_up.dart';
// import 'package:CHATS_Vendor/ui/screen/transaction_view.dart';
// import 'package:CHATS_Vendor/ui/screen/verify_sms_view.dart';
// import 'package:CHATS_Vendor/modules/wallet/wallet_view.dart';
// import 'package:flutter/material.dart';

// class RoutePath {
//   // ignore: missing_return
//   static Route<dynamic> routePath(RouteSettings routeSettings) {
//     final args = routeSettings.arguments;
//     switch (routeSettings.name) {
//       case Routes.acceptPaymentsView:
//         return MaterialPageRoute(builder: (_) => AcceptPaymentsView());
//         break;

//       case Routes.splashScreen:
//         return MaterialPageRoute(builder: (_) => SplashScreen());
//         break;
//       case Routes.walletView:
//         return MaterialPageRoute(builder: (_) => WalletView());
//         break;
//       case Routes.onboardingScreen:
//         return MaterialPageRoute(builder: (_) => OnboardingScreen());
//         break;
//       case Routes.loginScreen:
//         return MaterialPageRoute(builder: (_) => LoginScreen());
//         break;
//       case Routes.signUpScreen:
//         return MaterialPageRoute(builder: (_) => SignUpView());
//         break;
//       case Routes.transactionView:
//         return MaterialPageRoute(builder: (_) => TransactionView());
//         break;
//         // case Routes.profileSettingsView:
//         //   return MaterialPageRoute(builder: (_) => ProfileSettings());
//         break;
//       case Routes.security:
//         return MaterialPageRoute(builder: (_) => SecurityView());
//         break;
//       // case Routes.cardAndPaymentView:
//       //   return MaterialPageRoute(builder: (_) => CardAndPaymentsView());
//       // break;
//       case Routes.myCampaigns:
//         return MaterialPageRoute(builder: (_) => CampaignsVew());
//         break;
//       case Routes.homeView:
//         return MaterialPageRoute(builder: (_) => HomeView());
//         break;
//       case Routes.profileView:
//         return MaterialPageRoute(builder: (_) => ProfileView());
//         break;
//       case Routes.scanCodeView:
//         return MaterialPageRoute(builder: (_) => ScanQRView());
//         break;

//       case Routes.helpSupport:
//         return MaterialPageRoute(builder: (_) => HelpSupportView());

//       case Routes.paymentSummary:
//         return MaterialPageRoute(
//             builder: (_) => PaymentSummaryView(cartData: args as List));

//       case Routes.paymentQRCode:
//         return MaterialPageRoute(
//             builder: (_) => PaymentQRCodeView(qrData: args as String));

//       case Routes.paymentCreate:
//         return MaterialPageRoute(
//             builder: (_) => PaymentCreateView(campaignId: args as int));

//       case Routes.verifySMSView:
//         return MaterialPageRoute(
//             builder: (_) => VerifySMSView(qrData: args as String));

//       case Routes.paymentConfirmation:
//         return MaterialPageRoute(
//             builder: (_) => PaymentConfirmView(beneficiaryData: args as Map));

//       case Routes.personalInfo:
//         return MaterialPageRoute(builder: (_) => PersonalInfo());

//       case Routes.account:
//         return MaterialPageRoute(builder: (_) => Account());

//       case Routes.mySettings:
//         return MaterialPageRoute(builder: (_) => SettingsView());

//       case Routes.kycStatus:
//         return MaterialPageRoute(builder: (_) => KYCstatus());

//       case Routes.setPIN:
//         return MaterialPageRoute(builder: (_) => SetPINView());

//       case Routes.changePIN:
//         return MaterialPageRoute(builder: (_) => ChangePINView());

//       case Routes.changePassword:
//         return MaterialPageRoute(builder: (_) => ChangePasswordView());

//       case Routes.resetPassword:
//         return MaterialPageRoute(builder: (_) => ResetPasswordView());

//         break;
//       default:
//         return MaterialPageRoute(
//           builder: (_) => SafeArea(
//             child: Scaffold(
//               body: Center(
//                 child: Text("No Route defined for ${routeSettings.name}"),
//               ),
//             ),
//           ),
//         );
//     }
//   }
// }
