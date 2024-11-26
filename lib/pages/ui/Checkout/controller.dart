import 'package:aegislabs/common/base_controller.dart';
import 'package:aegislabs/core/models/products/products_model.dart';
import 'package:get/get.dart';

class CheckoutController extends BaseController {
  final args = Get.arguments;
  final RxString token = ''.obs;

  final products = Rx<Products?>(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    products.value = args;
  }

}
