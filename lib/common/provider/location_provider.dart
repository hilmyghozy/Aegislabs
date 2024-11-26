// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:aegislabs/common/provider/storage_provider.dart';
// import 'package:aegislabs/core/logger/logger_types.dart';
// import 'package:geolocator/geolocator.dart';

// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:permission_handler/permission_handler.dart';

// class LocationProvider extends GetxService with ProviderLogger {
//   static LocationProvider get to => Get.find();

//   LocationProvider({required this.storage});

//   StorageProvider storage;

//   RxBool isAccessAllowed = false.obs;
//   RxBool serviceEnabled = false.obs;

//   var position = Rx<Position?>(null);

//   Future<LocationProvider> init() async {
//     isAccessAllowed.value = storage.getBool(STORAGE_LOCATION_PERMISSION);
//     return this;
//   }

//   Future<PermissionStatus> requestPermission() async {
//     var status = await Permission.location.request();
//     if (status.isDenied || status.isPermanentlyDenied) {
//       openAppSettings();
//     }
//     isAccessAllowed.value = !isAccessAllowed.value;
//     storage.setBool(STORAGE_LOCATION_PERMISSION,
//         !storage.getBool(STORAGE_LOCATION_PERMISSION));
//     return status;
//   }

//   Future<PermissionStatus> determinePosition(
//       {Function(Position? data)? onFinish,
//       Function(PermissionStatus status)? onDenied}) async {
//     var status = await requestPermission();
//     if (status.isGranted) {
//       position.value = await Geolocator.getCurrentPosition();
//       if (onFinish != null) onFinish(position());
//     } else {
//       if (onDenied != null) onDenied(status);
//     }
//     return status;
//   }

  // Future<Uint8List?> getStaticMapImage(
  //     double latitude, double longitude) async {
  //   String apiKey =
  //       'AIzaSyD5AlVTBwNMBmWL0yM7yLWW3pWj3gqBIuc'; // Replace with your Google Maps API key
  //   String staticMapUrl =
  //       'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=20&size=500x500&scale=2&maptype=roadmap&markers=icon:https://i.imgur.com/iehAvBz.png|${latitude},${longitude}&key=$apiKey';
  //   try {
  //     final response = await http.get(Uri.parse(staticMapUrl));
  //     if (response.statusCode == 200) {
  //       return response.bodyBytes;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // String generateStaticMapImageUrl(LatLng center, String labelText,
  //     {int height = 500, int width = 500}) {
  //   const zoom = 17.0; // Specify the zoom level for the map
  //   var accessToken = dotenv.env["MAPBOX_KEY"]!;
  //   const style = 'streets-v11';
  //   const retina = '@2x';

  //   const markerColor = 'FF0000';
  //   const textColor = '000000';
  //   const textSize = 16;
  //   final marker =
  //       'pin-m+${markerColor}(${center.longitude},${center.latitude})';
  //   final label =
  //       'text:${labelText}+${textSize}+${textColor}(${center.longitude},${center.latitude})';

  //   return 'https://api.mapbox.com/styles/v1/mapbox/$style/static/'
  //       '$marker' // Add the marker to the URL
  //       '$label/' // Add the marker to the URL
  //       '${center.longitude},${center.latitude},$zoom.0,0.00,0.00/'
  //       '${width}x${height}$retina?access_token=$accessToken';
  // }

  // Future<String?> reverseGeocode(double latitude, double longitude) async {
  //   var accessToken = dotenv.env["MAPBOX_KEY"]!;
  //   final url =
  //       'https://api.mapbox.com/geocoding/v5/mapbox.places/${longitude},${latitude}.json?country=id&proximity=ip&types=neighborhood&access_token=$accessToken';

  //   final response = await http.get(Uri.parse(url));

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);

  //     if (data['features'].isNotEmpty) {
  //       loggy.warning(data['features'][0]);
  //       return data['features'][0]['text'];
  //     }
  //   }
  //   return null;
  // }

  // Future<String?> getAddressFromLatLong(
  //     double latitude, double longitude) async {
  //   String apiKey = 'AIzaSyD5AlVTBwNMBmWL0yM7yLWW3pWj3gqBIuc';
  //   String url =
  //       'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var result2 = Geocoding.fromJson(json.decode(response.body));
  //       if (result2.status == 'OK') {
  //         var addressComponent1 = getAddressComponentLongName(
  //             result2.results?[0].addressComponents, "level_4");
  //         var addressComponent2 = getAddressComponentLongName(
  //             result2.results?[0].addressComponents, "level_3");
  //         var addressComponent3 = getAddressComponentLongName(
  //             result2.results?[0].addressComponents, "level_2");
  //         var addressComponent4 = getAddressComponentLongName(
  //             result2.results?[0].addressComponents, "level_1");

  //         if (addressComponent1.isNotEmpty) {
  //           return addressComponent1;
  //         }
  //         if (addressComponent2.isNotEmpty) {
  //           return addressComponent2;
  //         }
  //         if (addressComponent3.isNotEmpty) {
  //           return addressComponent3;
  //         }
  //         if (addressComponent4.isNotEmpty) {
  //           return addressComponent4;
  //         }
  //         loggy.error('No address found');
  //         return 'No address found';
  //       } else {
  //         loggy.error('No address found');
  //         return 'No address found';
  //       }
  //     } else {
  //       loggy.error('Error occurred');
  //       return 'Error occurred';
  //     }
  //   } catch (e) {
  //     loggy.error(e);
  //     return 'Error occurred';
  //   }
  // }

  // String getAddressComponentLongName(
  //     List<AddressComponent>? components, String type) {
  //   for (var component in components!) {
  //     if (component.types?.first.contains(type) ?? false) {
  //       return component.longName ?? '';
  //     }
  //   }

  //   return '';
  // }

  // Future<bool> isMapAppAvailable() async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isIOS) {
  //     // Requires import 'dart:io'
  //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //     return await canLaunchUrlString('http://maps.apple.com/');
  //   } else {
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     return await canLaunchUrlString('geo:0,0?q=');
  //   }
  // }
// }
