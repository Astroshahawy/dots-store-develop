import 'package:dots/app/features/Wallet/View/wallet_page.dart';
import 'package:dots/app/features/drawer/widget/switch_widget.dart';
import 'package:dots/core/route/routes.dart';
import 'package:dots/injection/injection_container.dart';
import 'package:easy_localization/easy_localization.dart' as loc;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geeks_service/geeks_service.dart';
import 'package:geeks_theme/geeks_theme.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_emoji_high_contrast.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/ph.dart';

import '../../../core/route/route_name.dart';
import '../../../core/utils/const_file.dart';
import '../../../core/utils/local_storage/local_storage.dart';
import '../../../core/utils/local_storage/storage_keys.dart';
import '../../../l10n/locale_keys.g.dart';
import '../../components/custom_toast_w.dart';
import '../auth/logic/blocs/logout_cubit/logout_cubit.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameSTR = Storage.getString(StorageAuthKeys.nameSTR) ?? '';
    final phoneSTR = Storage.getString(StorageAuthKeys.phoneSTR) ?? '';
    final userTypeINT = Storage.getInt(StorageAuthKeys.userTypeINT);

    return BlocProvider<LogoutCubit>(
      create: (context) => injector<LogoutCubit>(),
      child: BlocListener<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state.status == const ResponseStatus.success()) {
            toast(
              state.message,
              success: true,
            );
            context.pushName(RouteName.login);
          } else if (state.status == const ResponseStatus.noInternetC()) {
            toast(
              loc.tr('no_internet_str'),
            );
          } else if (state.status == const ResponseStatus.error()) {
            toast(
              state.message,
            );
          }
        },
        child: Drawer(
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  GP.g24(),

                  DrawerHeader(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: context.schemeGx.primary,
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.blueGrey[200],
                            backgroundImage: const NetworkImage(
                                'https://cdn4.iconfinder.com/data/icons/professions-avatars-1/135/88-512.png'),
                          ),
                        ),
                        // Text(
                        //   'Ahmed Shehata',
                        //   style: Theme.of(context).textTheme.labelLarge,
                        // ),
                        // ClipOval(
                        //   child: ImageNet(
                        //     imageSTR,
                        //     width: 70,
                        //     height: 70,
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                        Text(
                          nameSTR,
                        ).fontWeightGx(FontWeight.bold),
                        Text(
                          phoneSTR,
                        )
                            .textStyleGx(context.labelMediumGx)
                            // .fontSizeGx(14)
                            .fontWeightGx(FontWeight.bold),
                      ],
                    ),
                  ),
                  GP.g8(),

                  // DrawerNavigationItem(
                  //   iconData: Ic.baseline_shopping_bag,
                  //   title: LocaleKeys.myOrdersString.tr(),
                  //   onTap: () {},
                  // ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: _ThemeToggle(),
                  ),
                  DrawerNavigationItem(
                      iconData: Ic.baseline_support_agent,
                      title: loc.tr(LocaleKeys.helpSupportString),
                      onTap: () => context.pushName(RouteName.supportCenter)),
                  DrawerNavigationItem(
                      iconData: Ic.round_wallet,
                      title: loc.tr(LocaleKeys.walletString),
                      onTap: () => Get.to(const WalletPage())),
                  Visibility(
                    visible: userTypeINT == 2,
                    child: DrawerNavigationItem(
                      iconData: Ic.verified_user,
                      title: loc.tr('empolyees_str'),
                      onTap: () => context.pushName(RouteName.employeesPage),
                    ),
                  ),
                  DrawerNavigationItem(
                    iconData: Ph.question_bold,
                    title: loc.tr(LocaleKeys.howToUseString),
                    onTap: () => context.pushName(RouteName.howToUse),
                  ),
                  DrawerNavigationItem(
                    iconData: Ph.shield_check_fill,
                    title: loc.tr('privacy_policy_str'),
                    onTap: () => context.pushName(RouteName.privacyPolicyPage),
                  ),

                  // DrawerNavigationItem(
                  //   iconData: Ic.baseline_shopping_bag,
                  //   title: LocaleKeys.myOrdersString.tr(),
                  //   onTap: () {},
                  // ),

                  // DrawerNavigationItem(
                  //     iconData: Ic.round_support,
                  //     title: LocaleKeys.helpSupportString.tr(),
                  //     onTap: () => context.pushName(RouteName.supportCenter)),
                  // Visibility(
                  //   visible: userTypeINT == 2,
                  //   child: DrawerNavigationItem(
                  //     iconData: Ic.verified_user,
                  //     title: 'empolyees_str'.tr(),
                  //     onTap: () => context.pushName(RouteName.employeesPage),
                  //   ),
                  // ),
                  // DrawerNavigationItem(
                  //   iconData: Ph.question_bold,
                  //   title: LocaleKeys.howToUseString.tr(),
                  //   onTap: () => context.pushName(RouteName.howToUse),
                  // ),
                  DrawerNavigationItem(
                    iconData: FluentEmojiHighContrast.people_hugging,
                    title: loc.tr(LocaleKeys.contactUsString),
                    onTap: () => context.pushName(RouteName.contactUs),
                  ),
                  BlocSelector<LogoutCubit, LogoutState, ResponseStatus>(
                    selector: (state) {
                      return state.status;
                    },
                    builder: (context, status) {
                      return status == const ResponseStatus.loading()
                          ? const LinearProgressIndicator()
                          : DrawerNavigationItem(
                              iconData: Majesticons.logout,
                              title: loc.tr(LocaleKeys.logOutString),
                              onTap: () {
                                context.read<LogoutCubit>().logoutCu();
                              },
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerNavigationItem extends HookWidget {
  final String iconData;
  final String title;
  final Function() onTap;
  const DrawerNavigationItem({
    Key? key,
    required this.iconData,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context),
        ),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        leading: Iconify(
          iconData,
          color: myColors.primary,
        ),
        onTap: onTap,
        title: Text(title).textColorGx(
          myColors.primary,
        ),
        selectedTileColor: myColors.primary,
        selectedColor: myColors.onPrimary,
      ),
    );
  }
}

class _ThemeToggle extends HookWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useValueNotifier(0);

    return ToggleSection(
      firstElementTitle: loc.tr(LocaleKeys.lightString),
      secondElementTitle: loc.tr(LocaleKeys.nightString),
      icon: Icons.dark_mode,
      title: loc.tr(LocaleKeys.selectThemeMode),
      onToggle: (int? value) {
        context
            .readTheme()
            .updateThemeMode(value == 0 ? ThemeMode.light : ThemeMode.dark);
        // context.read<ThemeCubit>().setTheme(value!);
        selectedIndex.value = value!;
      },
      initIndex:
          context.readTheme().currentThemeMode == ThemeMode.light ? 0 : 1,
    );
  }
}
// class SignOutW extends StatelessWidget {
//   const SignOutW({
//     Key? key,
//     required this.onTap,
//   }) : super(key: key);
//   final void Function() onTap;
//   @override
//   Widget build(BuildContext context) {
//     return BlocSelector<SignOutCubit, SignOutState, ResponseStatus>(
//       selector: (state) {
//         return state.status;
//       },
//       builder: (context, state) {
//         return state == ResponseStatus.loading
//             ? const LinearProgressIndicator()
//             : TileDrawer(
//                 iconName: IconsFile.exit,
//                 title: StringFile.logout,
//                 onTap: onTap);
//       },
//     );
//   }
// }

class TileDrawer extends StatelessWidget {
  const TileDrawer({
    Key? key,
    required this.title,
    required this.onTap,
    required this.iconName,
    required this.icon,
  }) : super(key: key);
  final String title;
  final String iconName;
  final Widget icon;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.grey[50],
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
        child: Row(
          children: [
            // SvgImage(
            //   iconName,
            //   size: 18,
            // ),
            icon,
            GP.g16(),
            Text(
              title,
            ).fontWeightGx(FontWeight.bold),
          ],
        ),
      ),
    );
  }
}
