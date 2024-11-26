import 'package:aegislabs/common/base_controller.dart';
import 'package:aegislabs/common/extension/context.dart';
import 'package:aegislabs/core/models/products/products_model.dart';
import 'package:aegislabs/core/repository/auth_repository.dart';
import 'package:aegislabs/core/repository/product_repository.dart';
import 'package:aegislabs/pages/routes/pages.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  final ProductRepository repository = Get.find();
  final AuthRepository authRepo = Get.find();

  final products = RxList<Products?>();
  final categories = RxList<String?>();

  final RxString selectedCategories = 'all'.obs;

  final RxString token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
    getProducts();
    checkLogin();
  }

  checkLogin() async {
    await authRepo.getToken();
    print('myToken ${authRepo.token.toString()}');

    token.value = authRepo.token.toString();

    update();
  }

  Future<void> getCategories() async {
    try {
      setLoading(true);
      final result = await repository.getCategories();
      result.fold((l) {
        setLoading(false);
        Get.context!
            .showSnackBarMessage(l.errorMessage, type: SnackbarType.error);
      }, (r) {
        categories.value = r!.cast<String?>();
        categories.insert(0, 'all');
        setLoading(false);
      });
    } catch (e) {
      setLoading(false);
      loggy.error("submitForm >> $e");
    }
  }

  Future<void> getProducts() async {
    try {
      setLoading(true);
      final result = await repository.products();
      result.fold((l) {
        setLoading(false);
        Get.context!
            .showSnackBarMessage(l.errorMessage, type: SnackbarType.error);
      }, (r) {
        products.value = r!.cast<Products?>();
        setLoading(false);
      });
    } catch (e) {
      setLoading(false);
      loggy.error("getProducts >> $e");
    }
  }

  onTapCategories(String category) {
    if (selectedCategories.value != category) {
      selectedCategories.value = category;
      if (category == 'all') {
        getProducts();
      } else {
        getProductBaseOnCategories();
      }
    }
  }

  Future<void> getProductBaseOnCategories() async {
    try {
      setLoading(true);
      final result =
          await repository.getProductByCategories(selectedCategories.value);
      result.fold((l) {
        setLoading(false);
        Get.context!
            .showSnackBarMessage(l.errorMessage, type: SnackbarType.error);
      }, (r) {
        products.value = r!.cast<Products?>();
        setLoading(false);
      });
    } catch (e) {
      setLoading(false);
      loggy.error("getProductBaseOnCategories >> $e");
    }
  }

  goToLogin() {
    Get.toNamed(AppRoutes.LOGIN)?.then(checkLogin());
  }

  onTaplogout() async {
    setLoading(true);
    await authRepo.deleteToken();
    checkLogin();
    Future.delayed(const Duration(seconds: 2)).then((val) => setLoading(false));
  }

  onTapProduct(Products product) {
    Get.toNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
  }
}
