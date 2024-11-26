import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:aegislabs/common/app/VColor.dart';
import 'package:aegislabs/common/utils/Helpers.dart';

class VImageNetwork extends StatelessWidget {
  final String? uri;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final double borderRadius;

  const VImageNetwork(
      {Key? key,
      required this.uri,
      this.width,
      this.height,
      this.boxFit,
      this.borderRadius = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: uri!,
      width: width,
      height: height,
      fit: boxFit ?? BoxFit.cover,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: DecorationImage(
              image: imageProvider,
              fit: boxFit ?? BoxFit.cover,
            ),
          ),
        );
      },
      repeat: ImageRepeat.repeat,
      progressIndicatorBuilder: (context, url, progress) => Center(
        child: CircularProgressIndicator(
          value: progress.progress,
          color: VColor.accent,
        ),
      ),
      errorWidget: (context, url, error) {
        return CachedNetworkImage(
          imageUrl: uri!,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: boxFit ?? BoxFit.cover,
              ),
            ),
          ),
          repeat: ImageRepeat.repeat,
          progressIndicatorBuilder: (context, url, progress) => Center(
            child: CircularProgressIndicator(
              value: progress.progress,
              color: VColor.accent,
            ),
          ),
          errorWidget: (context, url, error) {
            return Center(
              child: Icon(
                Icons.warning,
              ),
            );
          },
        );
      },
    );
  }
}
