import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripedemo/constant.dart';
import 'package:stripedemo/stripe_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishableKey;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(centerTitle: true, title: Text("STRIPE DEMO")),
          body: Center(
            child: MaterialButton(
              elevation: 4.0,
              onPressed: () {
                StripeServices.instance.makePayment();
              },
              color: Colors.amberAccent,
              child: Text("PURCHASE"),
            ),
          )),
    );
  }
}
