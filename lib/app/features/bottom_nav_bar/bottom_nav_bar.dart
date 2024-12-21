// import 'package:dots/core/theme/color_theme.dart';
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
//     // ColorScheme myColor = context.schemeGx;

//     return Scaffold(
//       // drawer: const AppDrawer(),

//       body: BottomNavItems.bottomNavPages[selectedIndex.value],
//       bottomNavigationBar: NavigationBar(
//         animationDuration: const Duration(milliseconds: 600),
//         height: 60,
//         labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
//         destinations: [
//           ...BottomNavItems.bottomNavItems(
//               activeIcon: myColors.colorScheme.primary,
//               iconColor: myColors.colorScheme.secondaryContainer),
//         ],
//         onDestinationSelected: onItemTapped,
//         selectedIndex: selectedIndex.value,
//       ),
//     );
//   }
// }
