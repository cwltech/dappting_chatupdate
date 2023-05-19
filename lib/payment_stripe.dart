import 'dart:convert';
import 'package:dapp/constants/saveorderhistory.dart';
import 'package:dapp/loading_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Map<String, dynamic>? paymentIntentData;
String transaction = '';

class payment_stripe {
  static Future<void> makepayment(BuildContext context, String price,
      String user_id, String type, String plan_id) async {
    try {
      paymentIntentData = await createPaymentIntent(price, "INR");
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              // applePay: true,
              googlePay: PaymentSheetGooglePay(merchantCountryCode: "91"),
              style: ThemeMode.dark,
              merchantDisplayName: 'Hookup India'));
      displayPaymentSheet(context, user_id, type, plan_id);
    } catch (e) {
      print("exception ${e.toString()}");
    }
  }

  static createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateamount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51M057ASG0qpJpZRXDb2GfPIhTcUdEhYLDG9i9DjnyOHgi8e8lzdlIHwPGfoKnUemjfGcZIhtZgkK69pzogKuI2Ax00eFZ9urKM',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      Map mapRes = json.decode(response.body);
      transaction = mapRes["id"];
      print("responsestripe $mapRes $transaction");
      return jsonDecode(response.body.toString());
    } catch (e) {
      print("exception2 ${e.toString()}");
    }
  }

  static calculateamount(String amount) {
    final price = int.parse(amount) * 100;
    return price.toString();
  }

  static displayPaymentSheet(
      BuildContext context, String user_id, String type, String plan_id) async {
    try {
      await Stripe.instance.presentPaymentSheet(
          //     parameters: PresentPaymentSheetParameters(
          //   clientSecret: 'client_secret',
          //   confirmPayment: true,
          // )
          );
      paymentIntentData = null;
      circle(context);
      saveorderhistory.orderhistory(
          context, user_id, transaction, plan_id, type, "1");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Paid Successfully")));
      //Navigator.pop(context);
    } on StripeException catch (e) {
      print("StripeException${e.toString()}");
      //circle(context);
      // saveorderhistory.orderhistory(
      //     context, user_id, transaction, plan_id, type, "0");
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled"),
              ));
    }
  }
}
