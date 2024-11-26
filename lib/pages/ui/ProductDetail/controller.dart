import 'package:aegislabs/common/base_controller.dart';
import 'package:aegislabs/common/extension/context.dart';
import 'package:aegislabs/core/models/products/products_model.dart';
import 'package:aegislabs/core/repository/auth_repository.dart';
import 'package:aegislabs/core/repository/product_repository.dart';
import 'package:aegislabs/pages/routes/pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductDetailController extends BaseController {
  final args = Get.arguments;
  final AuthRepository authRepo = Get.find();
  final ProductRepository repository = Get.find();
  final RxString token = ''.obs;

  final products = Rx<Products?>(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    products.value = args;
    checkLogin();
  }

  checkLogin() async {
    await authRepo.getToken();
    token.value = authRepo.token.toString();

    update();
  }

  Future<void> onTapInsertCart() async {
    try {
      setLoading(true);
      final currentDate = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
      final result = await repository.addCart(
        payload: {
          "userId": 1,
          "date": formattedDate, // Use the formatted current date
          "products": [
            {
              "productId": products.value?.id,
              "quantity": 1,
            }
          ]
        },
      );
      result.fold((l) {
        setLoading(false);
        Get.context!
            .showSnackBarMessage(l.errorMessage, type: SnackbarType.error);
      }, (r) {
        Get.context!.showSnackBarMessage('Success insert Product into Cart',
            type: SnackbarType.success);
        setLoading(false);
      });
    } catch (e) {
      setLoading(false);
      loggy.error("login >> $e");
    }
  }

  onTapCheckOut() {
    Get.toNamed(AppRoutes.CHECKOUT, arguments: products.value);
  }
}
