import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripePaymentHandler {
  static intiStripe() async {
    await dotenv.load();
    Stripe.publishableKey = dotenv.env["STRIPE_PUBLIC_KEY"]!;
    Stripe.merchantIdentifier = 'for fitness app';
    await Stripe.instance.applySettings();
  }

  final client = http.Client();
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']!}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  Future<Map<String, dynamic>> createCustomer() async {
    const String url = 'https://api.stripe.com/v1/customers';
    var response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: {'description': 'New customer'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw 'Failed to register as a customer.';
    }
  }

  Future<Map<String, dynamic>> createPaymentIntents({
    required double amount,
    String currency = 'USD',
  }) async {
    String amountInString = amount.toInt().toString();

    const String url = 'https://api.stripe.com/v1/payment_intents';

    Map<String, dynamic> body = {
      'amount': amountInString,
      'currency': currency,
      'payment_method_types[]': 'card'
    };

    var response =
        await client.post(Uri.parse(url), headers: headers, body: body);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      log(response.headers.toString());
      throw 'Failed to create PaymentIntents.';
    }
  }

  Future<void> createCreditCard({
    required String customerId,
    required String paymentIntentClientSecret,
  }) async {
    try {
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        style: ThemeMode.system,
        merchantDisplayName: 'Fitness app',
        customerId: customerId,
        paymentIntentClientSecret: paymentIntentClientSecret,
      ));

      await Stripe.instance.presentPaymentSheet();
    } on StripeException {
      throw 'Payment cancelled by the user';
    } catch (e) {
      log(e.toString());
      throw 'Error Occured';
    }
  }
}
