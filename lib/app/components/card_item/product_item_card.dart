// import 'package:dots/app/components/image_net.dart';
// import 'package:dots/core/utils/const_file.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_extension_pk/flutter_extension_pk.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:iconify_flutter/iconify_flutter.dart';
// import 'package:iconify_flutter/icons/ic.dart';
// import 'package:iconify_flutter/icons/ph.dart';
// import 'package:like_button/like_button.dart';

// import '../../../core/theme/color_theme.dart';

// class ProductCardItem extends StatelessWidget {
//   const ProductCardItem({
//     Key? key,
//     required this.onTap,
//     required this.child,
//   }) : super(key: key);

//   factory ProductCardItem.verticalWithButton({
//     required productItem,
//     required VoidCallback onCardTap,
//     required VoidCallback onButtonTap,
//     required VoidCallback onFavoriteButton,
//   }) {
//     return ProductCardItem(
//       onTap: onCardTap,
//       child: ProductItem(
//         productItem: productItem,
//         onAddButton: onButtonTap,
//         onFavoriteButton: onFavoriteButton,
//       ),
//     );
//   }

//   final VoidCallback onTap;
//   final Widget child;
//   @override
//   Widget build(BuildContext context) {
//     final ColorTheme myColors = Theme.of(context).extension<ColorTheme>()!;
//     return Card(
//       elevation: 5,
//       shadowColor: Colors.grey.shade100,
//       color: myColors.whiteColor,
//       // margin: const EdgeInsets.all(12),
//       child: Pd.p8(child: child),
//     );
//   }
// }

// class ProductItem extends HookWidget {
//   const ProductItem({
//     Key? key,
//     required this.productItem,
//     required this.onAddButton,
//     required this.onFavoriteButton,
//   }) : super(key: key);
//   final ProductModel productItem;
//   final VoidCallback onAddButton;
//   final VoidCallback onFavoriteButton;
//   @override
//   Widget build(BuildContext context) {
//     final isSelected = useValueNotifier(false);
//     final ColorTheme myColors = Theme.of(context).extension<ColorTheme>()!;

//     return Stack(
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             ClipRRect(
//               borderRadius: BorderRadius.circular(ConstSizes.radius8),
//               clipBehavior: Clip.antiAlias,
//               child: const ImageNet(
//                 'https://iili.io/hSQ9N1.jpg',
//                 width: double.infinity,
//                 height: 100,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             GP.g8(),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 GP.g4(),
//                 Text('${productItem.name}')
//                     .textStyleGx(context.labelLargeGx)
//                     .boldGx()
//                     .textDirectionGx(TextDirection.ltr)
//                     .maxLinesGx(2)
//                     .overflowGx(TextOverflow.ellipsis),
//                 GP.g4(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     const Text('-20%')
//                         .textStyleGx(context.labelLargeGx)
//                         .textDirectionGx(TextDirection.ltr)
//                         .textColorGx(myColors.primaryColor)
//                         .boldGx(),
//                     GP.g4(),
//                     Text('${productItem.price}')
//                         .textStyleGx(context.labelLargeGx)
//                         .textDirectionGx(TextDirection.ltr)
//                         .textColorGx(myColors.secondaryColor)
//                         .boldGx(),
//                   ],
//                 ),
//                 const Text('⭐ 4.5')
//                     .textStyleGx(context.labelLargeGx)
//                     .textColorGx(myColors.txtDark)
//                     .boldGx(),
//                 GP.g4(),
//                 // Text('${productItem.id}')
//                 //     .textStyle(context.titleLarge)
//                 //     .bold()
//                 //     .textColor(Colors.red)
//                 //     .overflowEx(TextOverflow.ellipsis),
//               ],
//             ),
//           ],
//         ),
//         Positioned(
//           top: 3,
//           right: 3,
//           child: ClipOval(
//             child: SizedBox(
//               width: ConstSizes.s32,
//               height: ConstSizes.s32,
//               child: ColoredBox(
//                 color: myColors.txtLight.withOpacity(0.5),
//                 child: LoveButton(
//                   size: 20,
//                     isSelected: isSelected,
//                     onFavoriteButton: onFavoriteButton,
//                     myColors: myColors),
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 4,
//           right: 4,
//           child: InkWell(
//             onTap: onAddButton,
//             child: ClipOval(
//               child: Material(
//                 color: context.themeGx.primaryColor,
//                 child: Sizer.s32(
//                   child: Icon(
//                     Icons.add,
//                     size: 26.5,
//                     color: context.schemeGx.surface,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class LoveButton extends StatelessWidget {
//   const LoveButton({
//     Key? key,
//     required this.isSelected,
//     required this.onFavoriteButton,
//     required this.myColors,
//     this.size = 30.0,
//   }) : super(key: key);

//   final ValueNotifier<bool> isSelected;
//   final VoidCallback onFavoriteButton;
//   final ColorTheme myColors;
//   final double size;
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//         valueListenable: isSelected,
//         builder: (context, value, _) {
//           return LikeButton(
//             size: size,
//             isLiked: isSelected.value,
//             onTap: (isLiked) async {
//               isSelected.value = !isSelected.value;
//               onFavoriteButton();
//               return !isLiked;
//             },
//             likeBuilder: (isLiked) {
//               return Iconify(
//                 isLiked ? Ic.sharp_favorite : Ph.heart_straight,
//                 color: isLiked ? myColors.redColor : myColors.primaryColor,
//                 size: ConstSizes.s32,
//               );
//             },
//           );
//           // return AnimatedCrossFade(
//           //   duration: const Duration(milliseconds: 200),
//           //   firstCurve: Curves.easeInQuad,
//           //   secondCurve: Curves.easeInQuad,
//           //   firstChild: Iconify(
//           //     Ic.sharp_favorite,
//           //     color: myColors.redColor,
//           //     size: ConstSizes.s32,
//           //   ),
//           //   secondChild: Iconify(
//           //     Ph.heart_straight,
//           //     color: myColors.primaryColor,
//           //     size: ConstSizes.s32,
//           //   ),
//           //   crossFadeState: isSelected.value
//           //       ? CrossFadeState.showFirst
//           //       : CrossFadeState.showSecond,
//           // );
//         });
//   }
// }
