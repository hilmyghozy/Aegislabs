import 'package:aegislabs/pages/ui/ProductDetail/controller.dart';
import 'package:get/get.dart';

class ProductDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailController>(() => ProductDetailController());
  }
}
