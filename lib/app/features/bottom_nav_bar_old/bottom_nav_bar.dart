// import 'package:dots/app/features/drawer/views/pages/drawer.dart';
// import 'package:dots/core/theme/color_theme.dart';
// import 'package:dots/core/utils/const_file.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';

// import 'bottom_nav_items.dart';

// class MainLayerPage extends HookWidget {
//   const MainLayerPage({
//     Key? key,
//     this.index = 0,
//   }) : super(key: key);
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     final ColorTheme myColors = Theme.of(context).extension<ColorTheme>()!;

//     final selectedIndex = useState<int>(index);
//     // final scaffoldKey = GlobalKey<ScaffoldState>();
//     void onItemTapped(int index) {
//       selectedIndex.value = index;
//     }

//     return Scaffold(
//       // appBar: CustomAppBar(
//       //   centerTitle: true,
//       //   title: SvgPicture.asset(
//       //     AssetsFile.svg('logo2.svg'),
//       //     color: context.themeGx.colorScheme.onBackground,
//       //     height: 25,
//       //   ),
//       // ),
//       drawer: const AppDrawer(),
//       extendBody: true,
//       floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
//       floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
//       floatingActionButton: ClipOval(
//         child: ColoredBox(
//           color: Colors.red,
//           child: IconButton(
//               color: Colors.amber,
//               onPressed: () {},
//               icon: const Icon(Icons.qr_code)),
//         ),
//       ),
//       body: BottomNavItems.bottomNavPages[selectedIndex.value],
//       bottomNavigationBar: BottomAppBar(
//         //bottom navigation bar on scaffold
//         color: Colors.redAccent,
//         shape: const CircularNotchedRectangle(), //shape of notch
//         notchMargin:
//             5, //notche margin between floating button and bottom appbar
//         child: Row(
//           //children inside bottom appbar
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             GP.g16(),
//             IconButton(
//               icon: const Icon(
//                 Icons.menu,
//                 color: Colors.white,
//               ),
//               onPressed: () {},
//             ),
//             IconButton(
//               icon: const Icon(
//                 Icons.search,
//                 color: Colors.white,
//               ),
//               onPressed: () {},
//             ),
//             IconButton(
//               icon: const Icon(
//                 Icons.print,
//                 color: Colors.white,
//               ),
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
