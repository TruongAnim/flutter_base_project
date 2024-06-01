// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';

// import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';

// const String weekKey = 'premium_week';
// const String monthKey = 'premium_month';
// const String yearKey = 'premium_year';

// const List<String> listProductId = <String>[weekKey, monthKey, yearKey];

// class InAppPurchaseService {
//   static InAppPurchaseService instance = InAppPurchaseService();

//   static InAppPurchaseService getInstance() {
//     return instance;
//   }

//   final InAppPurchase _inAppPurchase = InAppPurchase.instance;
//   late StreamSubscription<List<PurchaseDetails>> _subscription;
//   final List<ProductDetails> _products = [];

//   List<ProductDetails> get products {
//     final newList = List.of(_products);
//     newList.removeWhere((element) => element.rawPrice <= 0);
//     if (newList.length >= 2) {
//       final ProductDetails temp = newList[0];
//       newList[0] = newList[1];
//       newList[1] = temp;
//     }
//     return newList;
//   }

//   void dispose() {
//     _subscription.cancel();
//     _iosRemoveDelegate();
//   }

//   ///
//   /// Init service.
//   ///
//   Future<bool> initService() async {
//     final bool _isAvailable = await _inAppPurchase.isAvailable();

//     if (!_isAvailable) {
//       log('In app purchase is not available');
//       return false;
//     }

//     // if (Platform.isIOS) {
//     //   final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
//     //       _inAppPurchase.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
//     //   await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
//     // }

//     final ProductDetailsResponse _productDetailResponse =
//         await _inAppPurchase.queryProductDetails(listProductId.toSet());

//     if (_productDetailResponse.error != null) {
//       return false;
//     }

//     // Check have this package.
//     for (final product in _productDetailResponse.productDetails) {
//       print(
//           'product: ${product.id} ${product.title}, ${product.description}, ${product.price}, ${product.rawPrice}');
//       if (listProductId.contains(product.id)) {
//         _products.add(product);
//       }
//     }

//     _products.sort((ProductDetails a, ProductDetails b) =>
//         a.rawPrice.compareTo(b.rawPrice));
//     return true;
//   }

//   ///
//   /// Buy package.
//   ///
//   Future<void> purchasePackage(ProductDetails productDetails) async {
//     if (Platform.isIOS) {
//       final InAppPurchaseStoreKitPlatformAddition iapStoreKitPlatformAddition =
//           _inAppPurchase
//               .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
//       await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
//     }
//     final PurchaseParam purchaseParam = PurchaseParam(
//         productDetails: getFreeProductIfAvailable(productDetails));
//     _inAppPurchase.buyNonConsumable(
//       purchaseParam: purchaseParam,
//     );
//   }

//   ///
//   /// Restore purchase.
//   ///
//   ProductDetails getFreeProductIfAvailable(ProductDetails productDetails) {
//     for (final ProductDetails item in _products) {
//       if (item.id == productDetails.id && item.rawPrice <= 0) {
//         return item;
//       }
//     }
//     return productDetails;
//   }

//   ///
//   /// Restore purchase.
//   ///
//   Future<bool> restorePurchase() async {
//     try {
//       await _inAppPurchase.restorePurchases();
//       return true;
//     } catch (ex) {
//       log('restorePurchase $ex');
//       return false;
//     }
//   }

//   ///
//   /// Restore purchase.
//   ///
//   Future<bool> completePurchase(PurchaseDetails purchaseDetails) async {
//     try {
//       await _inAppPurchase.completePurchase(purchaseDetails);
//       return true;
//     } catch (ex) {
//       log(ex.toString());
//       return false;
//     }
//   }

//   ///
//   /// Listen subscriptions.
//   ///
//   void listenSubscriptions(Function(List<PurchaseDetails>) callback) {
//     final Stream<List<PurchaseDetails>> purchaseUpdated =
//         _inAppPurchase.purchaseStream;
//     _subscription =
//         purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
//       callback(purchaseDetailsList);
//     }, onDone: () {
//       _subscription.cancel();
//     }, onError: (Object error) {
//       // handle error here.
//     });
//   }

//   Future<bool> verifyPurchase(PurchaseDetails purchaseDetails) {
//     // IMPORTANT!! Always verify a purchase before delivering the product.
//     // For the purpose of an example, we directly return true.
//     return Future<bool>.value(true);
//   }

//   void handleInvalidPurchase(PurchaseDetails purchaseDetails) {
//     // handle invalid purchase here if  _verifyPurchase` failed.
//   }

//   Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
//     // IMPORTANT!! Always verify purchase details before delivering the product.
//   }

//   void _iosRemoveDelegate() {
//     if (Platform.isIOS) {
//       final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
//           _inAppPurchase
//               .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
//       iosPlatformAddition.setDelegate(null);
//     }
//   }
// }
