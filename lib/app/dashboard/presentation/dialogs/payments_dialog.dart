import 'package:flutter/material.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/core/cloud_storage/global.dart';
import 'package:fusion_app_store/core/cloud_storage/keys.dart';
import 'package:fusion_app_store/core/cloud_storage/refs.dart';
import 'package:fusion_app_store/core/global/core_app_button.dart';
import 'package:fusion_app_store/core/global/message_box.dart';
import 'package:fusion_app_store/core/local_storage/database.dart';
import 'package:fusion_app_store/core/routing/route_service.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:razorpay_web/razorpay_web.dart';
import 'package:uuid/uuid.dart';

void showPaymentsDialog(BuildContext context, VoidCallback onSuccess) {
  showDialog(
    context: context,
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    builder: (context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: PaymentsDialog(onSuccess: onSuccess),
        ),
      );
    },
  );
}

class PaymentsDialog extends StatefulWidget {
  const PaymentsDialog({super.key, required this.onSuccess});

  final VoidCallback onSuccess;

  @override
  State<PaymentsDialog> createState() => _PaymentsDialogState();
}

class _PaymentsDialogState extends State<PaymentsDialog> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    final db = Get.find<FusionDatabase>();
    final user = (await db.getUserByEmail(GlobalFirebaseUtils.getCurrentUserLoginEmail()))!;
    final data = {
      StorageKeys.username: user.username,
      'paymentID': response.paymentId,
      'orderID': response.orderId,
    };
    await Refs.premiumUsers.doc(user.username).set(data);
    Get.back();
    widget.onSuccess();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    showMessage(
      title: "Payment Failed",
      description: "Something went wrong. Please Try again later.",
      type: MessageBoxType.error,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      height: 700,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 16,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Starting at just",
              style: AppTheme.fontSize(42).makeBold().withColor(Colors.white),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "\$5 ",
                  style:
                      AppTheme.fontSize(52).makeBold().withColor(Colors.white),
                ),
                Text(
                  "per month",
                  style:
                      AppTheme.fontSize(32).makeBold().withColor(Colors.white),
                ),
              ],
            ),
            Text(
              "Get top notch statistics to boost your productivity",
              style: AppTheme.fontSize(22).makeMedium().withColor(Colors.white),
            ),
            const Gap(25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTick("App Analytics"),
                _buildTick("Review Analytics"),
                _buildTick("Downloads Analytics"),
                _buildTick("Interaction Analytics"),
                _buildTick("Views Analytics"),
                _buildTick("Audience Analytics"),
              ],
            ),
            const Gap(25),
            CoreAppButton(
              text: "Go Premium Now",
              onPressed: () {
                var options = {
                  "key": "rzp_test_hbW4gHERtTIyfG",
                  'amount': 50000,
                  'name': 'Fusion App Store',
                  'description': 'Premium Dashboard Payment',
                  'prefill': {
                    'contact': '8888888888',
                    'email': 'test@razorpay.com'
                  }
                };
                _razorpay.open(options);
              },
              fontSize: 20,
              icon: const Icon(
                Icons.diamond_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTick(String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.done,
          size: 24,
          color: Colors.white,
        ),
        const Gap(10),
        Text(
          title,
          style: AppTheme.fontSize(24).makeMedium().withColor(Colors.white),
        ),
      ],
    );
  }
}
