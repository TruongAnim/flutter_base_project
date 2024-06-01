// import 'dart:async';

// import 'package:base_project/config/routes/base_routers.dart';
// import 'package:base_project/core/global/di_container.dart';
// import 'package:base_project/core/helper/toast.dart';
// import 'package:base_project/core/shared_preference/shared_preference_helper.dart';
// import 'package:get/get.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';

// import 'in_app_purcharse_sercice.dart';

// class PremiumController extends GetxController {
//   static const String premiumId = 'premiumId';

//   /// In app purchase.
//   final InAppPurchaseService _iapService = InAppPurchaseService.instance;
//   List<ProductDetails> productsList = <ProductDetails>[];

//   // Local premium state.
//   bool isUserPremium = false;
//   bool isIapServiceAvailable = false;

//   @override
//   void onInit() {
//     super.onInit();

//     // Init in app purchase.
//     _initInAppPurchase();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//     _iapService.dispose();
//   }

//   bool get isPremium {
//     return isUserPremium;
//   }

//   ///
//   /// Init in app purchase.
//   ///
//   Future<void> _initInAppPurchase() async {
//     isIapServiceAvailable = await _iapService.initService();
//     productsList = _iapService.products;
//     print(productsList);
//     _iapService.listenSubscriptions(_listenToPurchaseUpdated);
//     // Restore purchase mỗi khi bật app.
//     // Nếu đã mua thì sẽ update sang premium
//     // Nếu chưa mua thì premium = false;
//     _iapService.restorePurchase();
//     // productsList = getFakePackage();
//   }

//   ///
//   /// purchasePackage
//   ///
//   Future<void> purchasePackage(ProductDetails productDetails) async {
//     _iapService.purchasePackage(productDetails);
//   }

//   ///
//   /// restore Package
//   ///
//   Future<void> restorePurchase() async {
//     // EasyLoading.show(status: 'Restore premium...');
//     _iapService.restorePurchase();
//   }

//   ///
//   /// To home page.
//   ///
//   void toHomePage() {
//     Get.offAllNamed(BaseRouters.MAIN_NAVIGATOR);
//   }

//   ///
//   /// Listen purchase.
//   ///
//   Future<void> _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
//     for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
//       if (purchaseDetails.status == PurchaseStatus.canceled) {}
//       if (purchaseDetails.status == PurchaseStatus.error) {
//         showToastMessage(purchaseDetails.error?.message ?? '');
//       }
//       if (purchaseDetails.status == PurchaseStatus.purchased) {
//         _updatePremium(purchaseDetails: purchaseDetails);
//         if (purchaseDetails.pendingCompletePurchase) {
//           await _iapService.completePurchase(purchaseDetails);
//         }
//       }
//       if (purchaseDetails.status == PurchaseStatus.restored) {
//         _updatePremium(purchaseDetails: purchaseDetails);
//       }
//       continue;
//     }
//   }

//   ///
//   /// Update premium.
//   ///
//   Future<void> _updatePremium({required PurchaseDetails purchaseDetails}) async {
//     isUserPremium = true;
//     appGlobal<SharedPreferenceHelper>().setPremium(true);
//     handleNavigate();
//   }

//   Future<void> handleNavigate() async {
//     if (Get.currentRoute != BaseRouters.SPLASH) toHomePage();
//   }

//   void handleActionWithPremiumRole(Function? handleContinue, bool? canContinue) {
//     if (isUserPremium == true) {
//       if (handleContinue != null) {
//         handleContinue();
//       }
//     } else {
//       Get.toNamed(BaseRouters.GO_PREMIUM, arguments: {'handleContinue': handleContinue, 'canContinue': canContinue});
//     }
//   }
// }
