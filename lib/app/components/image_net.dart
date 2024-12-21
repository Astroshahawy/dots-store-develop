// ignore: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageNet extends StatelessWidget {
  const ImageNet(
    this.url, {
    Key? key,
    this.height,
    this.width,
    this.fit,
  }) : super(key: key);
  final String url;
  final double? height, width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: url,
      fit: fit ?? BoxFit.cover,
      errorWidget: (
        BuildContext context,
        String url,
        dynamic error,
      ) =>
          Image.network(
              'https://cdn.shopify.com/s/files/1/0405/8411/8424/products/250-gBeansforOnlineStores_Espresso.jpg?v=1618456179'
              // 'https://fratellidiamanti.com/ar/wp-content/themes/fratelli/img/notfound.png',
              ),
    );
  }
}
