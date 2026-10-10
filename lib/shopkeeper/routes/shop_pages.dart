import 'package:get/get.dart';
import 'package:localmarket/shopkeeper/auth/bindings/forgot_password_bindings.dart';
import 'package:localmarket/shopkeeper/auth/bindings/shop_registration_bindings.dart';
import 'package:localmarket/shopkeeper/auth/bindings/sign_in_binding.dart';
import 'package:localmarket/shopkeeper/auth/bindings/sign_up_bindings.dart';
import 'package:localmarket/shopkeeper/auth/sign_in.dart';
import 'package:localmarket/shopkeeper/auth/sign_up.dart';
import 'package:localmarket/shopkeeper/auth/view/forgot_password_view.dart';
import 'package:localmarket/shopkeeper/auth/view/shop_registration_view.dart';
import 'package:localmarket/shopkeeper/home/add_product/bindings/add_product_bindings.dart';
import 'package:localmarket/shopkeeper/home/add_product/view/add_product_view.dart';
import 'package:localmarket/common/common_bottom_navigation_bindings.dart';
import 'package:localmarket/shopkeeper/home/binding/shop_keeper_module_nav.dart';
import 'package:localmarket/common/common_bottom_nav.dart';
import 'package:localmarket/shopkeeper/home/offer_product/bindings/offer_product_bindings.dart';
import 'package:localmarket/shopkeeper/home/offer_product/view/offer_product_view.dart';
import 'package:localmarket/shopkeeper/home/view_product/bindings/view_product_bindings.dart';
import 'package:localmarket/shopkeeper/home/view_product/view/view_product_view.dart';
import 'package:localmarket/shopkeeper/profile/binding/profile_binding.dart';
import 'package:localmarket/shopkeeper/profile/view/profile_view.dart';
import 'package:localmarket/shopkeeper/routes/app_routes.dart';

final routes = [
  GetPage(
    name: AppRoutes.forgotPassword,
    page: () => const ForgotPasswordView(),
    binding: ForgotPasswordBinding(),
  ),
  GetPage(
    name: AppRoutes.signin,
    page: () => const PartnerSignInPage(),
    binding: PartnerSignInBinding(),
  ),
  GetPage(
    name: AppRoutes.signup,
    page: () => const PartnerSignupPage(),
    binding: PartnerSignUpBinding(),
  ),
  GetPage(
    name: AppRoutes.shopRegistration,
    page: () => ShopRegistrationView(partner: Get.arguments),
    binding: ShopRegistrationBinding(),
  ),
  GetPage(
    name: AppRoutes.shopkeeperbottom,
    page: () => const CommonBottomNavView(),
    binding: ShopkeeperHomeBinding(),
  ),
  GetPage(
    name: AppRoutes.addProduct,
    page: () => const AddProductView(),
    binding: AddProductBinding(),
  ),

  GetPage(
    name: AppRoutes.viewProduct,
    page: () => const ViewProductView(),
    binding: ViewProductBinding(),
  ),

  GetPage(
    name: AppRoutes.offerProduct,
    page: () => const OfferProductView(),
    binding: OfferProductBinding(),
  ),

  GetPage(
    name: AppRoutes.profile,
    page: () => const ProfileView(),
    binding: ProfileBinding(),
  ),
];
