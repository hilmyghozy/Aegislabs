import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../core/logger/logger_types.dart';
import 'utils/Helpers.dart';

class BaseController extends GetxController with Helpers, ControllerLogger {
  final RxBool _isLoading = false.obs;
  get isLoading => _isLoading.value;

  final RxBool _isValidate = false.obs;
  get isValidate => _isValidate.value;

  RxString error = "".obs;

  void setLoading(bool isLoading) {
    _isLoading.value = isLoading;
  }

  void setValidate(bool isValidate) {
    _isValidate.value = isValidate;
  }

  // @override
  // Ticker createTicker(TickerCallback onTick) {
  //   return Ticker(onTick, debugLabel: 'ticker');
  // }
}
