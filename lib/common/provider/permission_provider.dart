import 'dart:io';

import 'package:aegislabs/common/components/dialog/bottomsheet.dart';
import 'package:aegislabs/common/provider/config_provider.dart';
import 'package:aegislabs/common/provider/storage_provider.dart';
import 'package:aegislabs/core/logger/logger_types.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionProvider extends GetxService with ProviderLogger {
  static PermissionProvider get to => Get.find();

  late StorageProvider storage = Get.find();

  Future<PermissionProvider> init() async {
    requestNotifPermission();
    return this;
  }

  Future<PermissionStatus> requestLocationPermission() async {
    var status = await Permission.location.request();
    return status;
  }

  Future<PermissionStatus> requestNotifPermission() async {
    var status = await Permission.notification.request();
    return status;
  }

  Future<Map<Permission, PermissionStatus>> requestCameraPermissions() async {
    if (Platform.isAndroid) {
      var isAndroidT = await ConfigProvider.to.isAndroidT();
      return isAndroidT
          ? await [
              Permission.camera,
              Permission.photos,
            ].request()
          : await [
              Permission.camera,
              Permission.storage,
            ].request();
    }
    return await [
      Permission.camera,
    ].request();
  }

  Future<bool> checkImagePermissions() async {
    var isAndroidT = await ConfigProvider.to.isAndroidT();
    if (isAndroidT) {
      return await Permission.photos.isGranted == false ||
          await Permission.camera.isGranted == false;
    } else {
      return await Permission.storage.isGranted == false ||
          await Permission.camera.isGranted == false;
    }
  }

  Future<void> showImageRationale(
      {bool reshown = false,
      required Function(Map<Permission, PermissionStatus> status)
          onAction}) async {
    var reqPermission = await checkImagePermissions();
    if (reqPermission || reshown) {
      await CustomBottomSheet().showMessageDialog(
          title: 'Permission',
          message: 'This app require permission to access camera and photos',
          okText: 'Allow',
          showCancel: true,
          cancelText: 'Discard',
          onButtonClick: (button) async {
            if (button) {
              var status = await requestCameraPermissions();
              onAction.call(status);
              return;
            }
          });

      return;
    } else {
      onAction.call(await requestCameraPermissions());
      return;
    }
  }

  Future<void> showLocationRationale(
      {bool reshown = false,
      required Function(PermissionStatus status) onAction}) async {
    if (await Permission.location.isGranted == false) {
      await CustomBottomSheet().showMessageDialog(
          title: 'Location Permission',
          message: 'This app require permission to access your location',
          okText: 'Allow',
          isDismissible: false,
          showCancel: true,
          cancelText: 'Discard',
          onButtonClick: (button) async {
            if (button) {
              var status = await requestLocationPermission();
              await StorageProvider.to
                  .setBool(STORAGE_LOCATION_PERMISSION, true);
              onAction(status);
              return;
            } else {
              onAction(await Permission.location.status);
            }
          });
    } else {
      onAction(await Permission.location.status);
      return;
    }
  }
}
