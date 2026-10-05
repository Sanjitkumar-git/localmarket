import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/auth/controllers/shop_registration_controller.dart';
import 'package:localmarket/shopkeeper/auth/view/shop_registration_view.dart';



class ShopRegistrationPage extends StatelessWidget {
  const ShopRegistrationPage({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopRegistrationController>(
      init: ShopRegistrationController(),
      builder: (_) {
        return ShopRegistrationView(partner: user);
      },
    );
  }
}
