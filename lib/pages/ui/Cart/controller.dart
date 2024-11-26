import 'package:aegislabs/common/base_controller.dart';
import 'package:aegislabs/common/extension/context.dart';
import 'package:aegislabs/core/models/carts/carts_model.dart';
import 'package:aegislabs/core/repository/product_repository.dart';
import 'package:get/get.dart';

class CartController extends BaseController {
  final ProductRepository repository = Get.find();

  final carts = RxList<CartsModel?>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCarts();
  }

  Future<void> getCarts() async {
    try {
      setLoading(true);
      final result = await repository.getCarts();
      result.fold((l) {
        setLoading(false);
        Get.context!
            .showSnackBarMessage(l.errorMessage, type: SnackbarType.error);
      }, (r) async {
        carts.value = r!.cast<CartsModel?>();

        // Fetch product details for each cart item
        for (var cart in carts) {
          for (var cartItem in cart!.products!) {
            await _fetchProductDetails(cartItem);
          }
        }

        carts.refresh();

        setLoading(false);
      });
    } catch (e) {
      setLoading(false);
      loggy.error("getCarts >> $e");
    }
  }

  Future<void> _fetchProductDetails(Product cartItem) async {
    try {
      setLoading(true);
      final result = await repository.productsDetail(cartItem.productId!);
      result.fold((l) {
        setLoading(false);
        Get.context!
            .showSnackBarMessage(l.errorMessage, type: SnackbarType.error);
      }, (r) {
        cartItem.products = r;
        setLoading(false);
      });
    } catch (e) {
      setLoading(false);
      loggy.error("getCarts >> $e");
    }
  }

  Future<void> removeCart(int id) async {
    try {
      setLoading(true);
      final result = await repository.deleteCart(id);
      result.fold((l) {
        setLoading(false);
        Get.context!
            .showSnackBarMessage(l.errorMessage, type: SnackbarType.error);
      }, (r) {
        Get.context!.showSnackBarMessage('Remove Cart Success',
            type: SnackbarType.success);
        getCarts();
        setLoading(false);
      });
    } catch (e) {
      setLoading(false);
      loggy.error("getCarts >> $e");
    }
  }
}
