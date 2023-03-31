import 'package:CHATS_Vendor/core/services/local_storage_service.dart';
import 'package:CHATS_Vendor/core/services/store_service.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:CHATS_Vendor/modules/payment/screens/accept_payment_view.dart';
import 'package:CHATS_Vendor/modules/payment/screens/payment_confirm_view.dart';
import 'package:CHATS_Vendor/modules/payment/screens/payments_create_view.dart';
import 'package:CHATS_Vendor/modules/payment/screens/payments_qrcode.dart';
import 'package:CHATS_Vendor/modules/payment/screens/payments_summary_view.dart';
import 'package:CHATS_Vendor/modules/payment/screens/scan_code_view.dart';
import 'package:CHATS_Vendor/modules/payment/screens/verify_sms_view.dart';
import 'package:CHATS_Vendor/ui/view_model/base_view_model.dart';
import 'package:CHATS_Vendor/ui/view_model/create_order_VM.dart';
import 'package:CHATS_Vendor/ui/view_model/payment_view_VM.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PaymentModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => BaseViewModel()),
        Bind.factory((i) => SharedPref()),
        Bind.instance((i) => VendorService()),
        Bind.instance((i) => StoreService()),
        Bind.singleton((i) => CreateOrderVM()),
        Bind.singleton((i) => PaymentVM()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => AcceptPaymentsView()),
        ChildRoute(
          '/create',
          child: (_, args) => PaymentCreateView(
            campaignId: int.parse(args.queryParams['campaignId']!),
          ),
        ),
        ChildRoute(
          '/summary',
          child: (_, args) => PaymentSummaryView(
            order: args.data,
          ),
        ),
        ChildRoute(
          '/confirm',
          child: (_, args) => PaymentConfirmView(
            beneficiaryData: args.data,
          ),
        ),

        //* Pay method routes
        ChildRoute(
          '/gen_qrcode',
          child: (_, args) => PaymentQRCodeView(
            qrData: args.data,
          ),
        ),
        ChildRoute(
          '/scan_qrcode',
          child: (_, args) => ScanQRView(),
        ),
        ChildRoute(
          '/sms_token',
          child: (_, args) => VerifySMSView(
            qrData: args.data,
          ),
        ),
      ];
}
