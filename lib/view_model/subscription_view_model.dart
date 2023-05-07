import 'package:fitness_app_mvvm/utils/components/custom_snackbar.dart';
import 'package:fitness_app_mvvm/utils/locator/locator.dart';
import 'package:fitness_app_mvvm/utils/nav_service.dart';
import 'package:fitness_app_mvvm/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/stripe_service/stripe_api.dart';

class SubscriptionViewModel extends ChangeNotifier {
  final AuthViewModel authViewModel =
      Provider.of(locator<NavService>().nav.context);

  buySubscription() async {
    try {
      String customerId = "";
      if (authViewModel.user.data!.stripId == null) {
        final customer = await PaymentHandler().createCustomer();
        customerId = customer['id'];
        authViewModel.user.data!.stripId = customerId;
        await authViewModel.updateUser();
      } else {
        customerId = authViewModel.user.data!.stripId!;
      }

      final paymentIntent = await PaymentHandler().createPaymentIntents(
        amount: 15 * 100,
      );
      await PaymentHandler().createCreditCard(
        customerId: customerId,
        paymentIntentClientSecret: paymentIntent['client_secret'],
      );

      // update the user subcriptionDataTimestamp
      authViewModel.user.data!.subscriptionData =
          DateTime.now().add(const Duration(days: 30));

      await authViewModel.updateUser();
      locator<NavService>().nav.pop();
      AppSnacbars.snackbar("Congratulations, you have subscribed.");
    } catch (e) {
      locator<NavService>().nav.pop();
      AppSnacbars.errorSnackbar(e.toString());
    }
  }
}
