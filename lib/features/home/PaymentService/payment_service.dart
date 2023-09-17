import 'package:commerceapp/features/home/PaymentService/strip_api_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentService {
  static Future<void> makePayment(
      {required int amount,
      required String currency,
      required String customerId}) async {
    try {
      String clientSecret =
          await getClientSecret((amount * 100).toString(), currency);
      await displayPayMentSheet(
          clientSecret: clientSecret, customerId: customerId);
      await Stripe.instance.presentPaymentSheet();
    } catch (error) {
      print(error.toString());
    }
  }

  static Future displayPayMentSheet(
      {required String clientSecret, required String customerId}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: clientSecret,
      merchantDisplayName: "shopify",
    ));
  }

  static Future<String> getClientSecret(String amount, String currency) async {
    Dio dio = Dio();
    var response = await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${StripApiKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      ),
      data: {
        'amount': amount,
        'currency': currency,
      },
    );
    return response.data["client_secret"];
  
  }
}
