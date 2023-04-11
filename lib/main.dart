//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopos/firebase_options.dart';
import 'package:shopos/src/services/global.dart';
import 'package:shopos/src/services/locator.dart';
import 'package:shopos/src/utils.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  locator.registerLazySingleton(() => GlobalServices());
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// TODO uncomment this line
  await const Utils().checkUpdates();

  runApp(const MyApp());

}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //TODO Change UPI ID
  final upiDetails = UPIDetails(
      upiID: "97877725@paytm",
      payeeName: "Payee Name Here",
      amount: 1,
      transactionNote: "Hello World");
  final upiDetailsWithoutAmount = UPIDetails(
      upiID: "9167877725@paytm",
      payeeName: "Agnel Selvan",
      transactionNote: "Hello World");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('UPI Payment QRCode Generator'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("UPI Payment QRCode without Amount",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              UPIPaymentQRCode(
                upiDetails: upiDetailsWithoutAmount,
                size: 200,
                embeddedImagePath: 'assets/images/logo.png',
                embeddedImageSize: const Size(60, 60),
              ),
              Text(
                "Scan QR to Pay",
                style: TextStyle(color: Colors.grey[600], letterSpacing: 1.2),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("UPI Payment QRCode with Amount",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              UPIPaymentQRCode(
                upiDetails: upiDetails,
                size: 200,
                upiQRErrorCorrectLevel: UPIQRErrorCorrectLevel.low,
              ),
              Text(
                "Scan QR to Pay",
                style: TextStyle(color: Colors.grey[600], letterSpacing: 1.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
