import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:stripedemo/constant.dart';

class StripeServices {
  StripeServices._();

  static final StripeServices instance = StripeServices._();

  Future<void> makePayment() async {
    try {
      String? paymentIntentClientSecret =
          await _createPaytmentIntent(10, "usd");

      print(paymentIntentClientSecret);

      if (paymentIntentClientSecret == null) return;

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: "PRIYA",
      ));
      await _processPayment();
    } catch (e) {
      print(e);
    }
  }

  Future<String?> _createPaytmentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };

      var response = await dio.post("https://api.stripe.com/v1/payment_intents",
          data: data,
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            'Authorization': 'Bearer $secretKey',
            'Content-Type': 'application/x-www-form-urlencoded'
          }));

      return response.data["client_secret"];
    } catch (e) {
      print(e);
    }
    return null;
  }

  String _calculateAmount(int amount) {
    int calculatedAmt = amount * 100;
    return calculatedAmt.toString();
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print(e);
    }
  }
}
